Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDCBA7D1F09
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Oct 2023 21:20:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231972AbjJUTUY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Oct 2023 15:20:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229633AbjJUTUW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Oct 2023 15:20:22 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A89011B;
        Sat, 21 Oct 2023 12:20:17 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 318DDC433C8;
        Sat, 21 Oct 2023 19:20:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1697916016;
        bh=nKj8aK3yWLZMRYvDNxgE4X1KMBF5HXTE3i4lzpALF0A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YGSV4tFOZ+DIvDrqjWBO/FKw31AoFM/fbYM5YZ2YsBzaDO5uDf7oSfuZANftSUdET
         +SAYcLNgYipAbY1MHbW0Pu/6yxbhHNCpP9VaR4b3vocKLLY3OEo6VDjIZmqI7dk1QZ
         3/wm1vgpyXWU+ELx4hxoV2hdXDUW8W/IobcRHLH0=
Date:   Sat, 21 Oct 2023 21:20:13 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     luka177 <lukapanio@gmail.com>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Tony Luck <tony.luck@intel.com>,
        "Guilherme G . Piccoli" <gpiccoli@igalia.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2 2/2] arm64: dts: qcom: sm8250-xiaomi-pipa: Add initial
 device tree
Message-ID: <2023102127-bash-stool-95a8@gregkh>
References: <20231021173317.185460-1-lukapanio@gmail.com>
 <20231021173317.185460-2-lukapanio@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231021173317.185460-2-lukapanio@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 21, 2023 at 07:33:17PM +0200, luka177 wrote:
> Initial support for Xiaomi Pad 6 tablet, that have sm8250 soc.
> 
> Signed-off-by: luka177 <lukapanio@gmail.com>
> ---
>  arch/arm64/boot/dts/qcom/Makefile             |   1 +
>  .../boot/dts/qcom/sm8250-xiaomi-pipa.dts      | 625 ++++++++++++++++++
>  2 files changed, 626 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/qcom/sm8250-xiaomi-pipa.dts
> 

Hi,

This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
a patch that has triggered this response.  He used to manually respond
to these common problems, but in order to save his sanity (he kept
writing the same thing over and over, yet to different people), I was
created.  Hopefully you will not take offence and will fix the problem
in your patch and resubmit it so that it can be accepted into the Linux
kernel tree.

You are receiving this message because of the following common error(s)
as indicated below:

- It looks like you did not use your name for the patch on either
  the Signed-off-by: line, or the From: line (both of which have to
  match).  Please read the kernel file,
  Documentation/process/submitting-patches.rst for how to do this
  correctly.

- This looks like a new version of a previously submitted patch, but you
  did not list below the --- line any changes from the previous version.
  Please read the section entitled "The canonical patch format" in the
  kernel file, Documentation/process/submitting-patches.rst for what
  needs to be done here to properly describe this.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot
