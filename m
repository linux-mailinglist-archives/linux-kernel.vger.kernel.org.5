Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53E21784468
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 16:34:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236792AbjHVOej (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 10:34:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234968AbjHVOei (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 10:34:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A99B185
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 07:34:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1FDAE65981
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 14:34:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 225C8C433C8;
        Tue, 22 Aug 2023 14:34:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1692714875;
        bh=qesgnanR+kvRJMERmNETh7282OJpHpV8Cbo0EzXRZh4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KFhfEQS0mOj/vPNtxTms6Zs3/5ebJia2MV/T+1pSMGYNQiDILzjXudwkMII0wCmAo
         o7GTkZxozyfY72Xa/PdOo4j6OYsUBSL4uDrTGu1COexFkzJmGIGs0EVpXcsD7zQAwn
         4to5H2Ex4WEjxumDRo1dmnz8+QTjiuypoJCR4lpc=
Date:   Tue, 22 Aug 2023 16:34:32 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/22] nvmem: patches for v6.6
Message-ID: <2023082217-banter-craftwork-281a@gregkh>
References: <20230814165252.93422-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230814165252.93422-1-srinivas.kandagatla@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 14, 2023 at 05:52:30PM +0100, Srinivas Kandagatla wrote:
> Here are some nvmem patches slightly more than usual for 6.6 that includes
> 
> - Support for NXP eFuse, qcom secure qfprom, QCM2290 nvmem providers
> - core level cleanup around error handling and layout creation.
> - few minor cleanups across providers drivers to use better
>   apis and a typo fix.
> 
> Can you please queue them up for 6.6.

I did, thanks, but your email system needs to be fixed:

 Link: https://lore.kernel.org/r/20230818124338.37880-1-yuehaibing@huawei.com
 Base: applies clean to current tree
       git checkout -b 20230818_yuehaibing_huawei_com HEAD
Applying: greybus: svc: Remove unused declarations
Press any key to continue...
Grabbing thread from lore.kernel.org/all/20230814165252.93422-1-srinivas.kandagatla@linaro.org/t.mbox.gz
Analyzing 23 messages in the thread
Checking attestation on all messages, may take a moment...
---
  ✗ [PATCH 1/22] dt-bindings: nvmem: fixed-cell: add compatible for MAC cells
  ✗ [PATCH 2/22] nvmem: sunxi_sid: Convert to devm_platform_ioremap_resource()
  ✗ [PATCH 3/22] nvmem: brcm_nvram: Use devm_platform_get_and_ioremap_resource()
  ✗ [PATCH 4/22] nvmem: lpc18xx_otp: Convert to devm_platform_ioremap_resource()
  ✗ [PATCH 5/22] nvmem: meson-mx-efuse: Convert to devm_platform_ioremap_resource()
  ✗ [PATCH 6/22] nvmem: rockchip-efuse: Use devm_platform_get_and_ioremap_resource()
  ✗ [PATCH 7/22] nvmem: stm32-romem: Use devm_platform_get_and_ioremap_resource()
  ✗ [PATCH 8/22] nvmem: qfprom: do some cleanup
  ✗ [PATCH 9/22] nvmem: uniphier: Use devm_platform_get_and_ioremap_resource()
  ✗ [PATCH 10/22] dt-bindings: nvmem: qfprom: Add compatible for MSM8226
  ✗ [PATCH 11/22] dt-bindings: nvmem: Add t1023-sfp efuse support
  ✗ [PATCH 12/22] nvmem: add new NXP QorIQ eFuse driver
  ✗ [PATCH 13/22] nvmem: Explicitly include correct DT includes
  ✗ [PATCH 14/22] nvmem: Kconfig: Fix typo "drive" -> "driver"
  ✗ [PATCH 15/22] dt-bindings: nvmem: Add compatible for QCM2290
  ✗ [PATCH 16/22] dt-bindings: nvmem: sec-qfprom: Add bindings for secure qfprom
  ✗ [PATCH 17/22] nvmem: sec-qfprom: Add Qualcomm secure QFPROM support
  ✗ [PATCH 18/22] nvmem: u-boot-env:: Replace zero-length array with DECLARE_FLEX_ARRAY() helper
  ✗ [PATCH 19/22] nvmem: core: Create all cells before adding the nvmem device
  ✗ [PATCH 20/22] nvmem: core: Return NULL when no nvmem layout is found
  ✗ [PATCH 21/22] nvmem: core: Do not open-code existing functions
  ✗ [PATCH 22/22] nvmem: core: Notify when a new layout is registered
  ---
  ✗ BADSIG: DKIM/linaro.org
