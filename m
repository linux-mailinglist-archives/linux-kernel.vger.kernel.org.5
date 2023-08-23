Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE4A7785AC9
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 16:35:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234563AbjHWOfq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 10:35:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231512AbjHWOfp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 10:35:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1555FE57
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 07:35:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9F02D60AC7
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 14:35:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7191DC433C7;
        Wed, 23 Aug 2023 14:35:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1692801342;
        bh=UZMPb//A5ndrvDvpyvFG9ouistZ2n2Y4FuC2QbzrgAo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=xXtCq5gZrpPYe6TuvIHqH5ZGo+xwSlFlbjoLWbgCWHKSaHT/imM2sk9wsM6YfMIaz
         muwIsfoHOUCo9ZnqGqGJNhhoRsMvmegJyMggsZXqBj7ei8/ILf0AT6OJjsxe6BSG7j
         56CPkNMIzbuRcdzu3QexF6agETGFXxdbE8cLtl1M=
Date:   Wed, 23 Aug 2023 16:35:40 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     srinivas.kandagatla@linaro.org
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 00/22] nvmem: patches for v6.6
Message-ID: <2023082329-impotence-escalator-61c5@gregkh>
References: <20230823132744.350618-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230823132744.350618-1-srinivas.kandagatla@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 23, 2023 at 02:27:22PM +0100, srinivas.kandagatla@linaro.org wrote:
> From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> 
> Here are some nvmem patches slightly more than usual for 6.6 that includes
> 
> - Support for NXP eFuse, qcom secure qfprom, QCM2290 nvmem providers
> - core level cleanup around error handling and layout creation.
> - few minor cleanups across providers drivers to use better
>   apis and a typo fix.
> 
> Can you please queue them up for 6.6.

Better, but I don't have your gpg key, is it in the kernel keyring?

Grabbing thread from lore.kernel.org/all/20230823132744.350618-1-srinivas.kandagatla@linaro.org/t.mbox.gz
Analyzing 23 messages in the thread
Checking attestation on all messages, may take a moment...
---
  ✗ [PATCH v2 1/22] dt-bindings: nvmem: fixed-cell: add compatible for MAC cells
  ✗ [PATCH v2 2/22] nvmem: sunxi_sid: Convert to devm_platform_ioremap_resource()
  ✗ [PATCH v2 3/22] nvmem: brcm_nvram: Use devm_platform_get_and_ioremap_resource()
  ✗ [PATCH v2 4/22] nvmem: lpc18xx_otp: Convert to devm_platform_ioremap_resource()
  ✗ [PATCH v2 5/22] nvmem: meson-mx-efuse: Convert to devm_platform_ioremap_resource()
  ✗ [PATCH v2 6/22] nvmem: rockchip-efuse: Use devm_platform_get_and_ioremap_resource()
  ✗ [PATCH v2 7/22] nvmem: stm32-romem: Use devm_platform_get_and_ioremap_resource()
  ✗ [PATCH v2 8/22] nvmem: qfprom: do some cleanup
  ✗ [PATCH v2 9/22] nvmem: uniphier: Use devm_platform_get_and_ioremap_resource()
  ✗ [PATCH v2 10/22] dt-bindings: nvmem: qfprom: Add compatible for MSM8226
  ✗ [PATCH v2 11/22] dt-bindings: nvmem: Add t1023-sfp efuse support
  ✗ [PATCH v2 12/22] nvmem: add new NXP QorIQ eFuse driver
  ✗ [PATCH v2 13/22] nvmem: Explicitly include correct DT includes
  ✗ [PATCH v2 14/22] nvmem: Kconfig: Fix typo "drive" -> "driver"
  ✗ [PATCH v2 15/22] dt-bindings: nvmem: Add compatible for QCM2290
  ✗ [PATCH v2 16/22] dt-bindings: nvmem: sec-qfprom: Add bindings for secure qfprom
  ✗ [PATCH v2 17/22] nvmem: sec-qfprom: Add Qualcomm secure QFPROM support
  ✗ [PATCH v2 18/22] nvmem: u-boot-env:: Replace zero-length array with DECLARE_FLEX_ARRAY() helper
  ✗ [PATCH v2 19/22] nvmem: core: Create all cells before adding the nvmem device
  ✗ [PATCH v2 20/22] nvmem: core: Return NULL when no nvmem layout is found
  ✗ [PATCH v2 21/22] nvmem: core: Do not open-code existing functions
  ✗ [PATCH v2 22/22] nvmem: core: Notify when a new layout is registered
  ---
  ✗ BADSIG: openpgp/srinivas.kandagatla@linaro.org
  ✓ Signed: DKIM/linaro.org

At least DKIM passes :)

Anyway, all now queued up, they pass my local build tests, thanks for
fixing that up.

greg k-h
