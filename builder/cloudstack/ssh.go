// Copyright (c) HashiCorp, Inc.
// SPDX-License-Identifier: MPL-2.0

package cloudstack

import (
	"fmt"

	"github.com/hashicorp/packer-plugin-sdk/multistep"
)

func commPort(state multistep.StateBag) (int, error) {
	commPort, hasPort := state.Get("commPort").(int)
	if !hasPort {
		return 0, fmt.Errorf("Failed to retrieve communication port")
	}

	return commPort, nil
}
