Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92FB875EA61
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 06:09:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229705AbjGXEJb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 00:09:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230036AbjGXEJ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 00:09:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C69CF119;
        Sun, 23 Jul 2023 21:09:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3469960C23;
        Mon, 24 Jul 2023 04:09:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A78DC433C8;
        Mon, 24 Jul 2023 04:09:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690171748;
        bh=N0iUCc13hu1pBscVJMQVogMlgQDLHIwk8l9zOCljf8k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AEIZvVdlMSToGK3Ls4+12L9h1Jvn62yUH4H4aoKHwKtgnNSK1sRs5AKQQY0IPPYbe
         puseJOUmAKf3fvKbBeehnXqwTX9tzggbhfMSsQX8Qp620ydvi15+klYMDkJcDMlxuY
         22o0OySp9IyyDvqli4plMYZ6cgxq86yUTfpIP1IU=
Date:   Mon, 24 Jul 2023 06:09:05 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Sasha Levin <sashal@kernel.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Pawel Laszczak <pawell@cadence.com>, balbi@kernel.org,
        linux-usb@vger.kernel.org
Subject: Re: [PATCH AUTOSEL 6.4 12/40] usb: cdns2: Device side header file
 for CDNS2 driver
Message-ID: <2023072453-rummage-patience-9750@gregkh>
References: <20230724013140.2327815-1-sashal@kernel.org>
 <20230724013140.2327815-12-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230724013140.2327815-12-sashal@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 23, 2023 at 09:31:12PM -0400, Sasha Levin wrote:
> From: Pawel Laszczak <pawell@cadence.com>
> 
> [ Upstream commit 0ca2026eea104adc1d0d356bca35915a1ab6e3e9 ]
> 
> Patch defines macros, registers and structures used by
> Device side driver.
> 
> Signed-off-by: Pawel Laszczak <pawell@cadence.com>
> Message-ID: <20230602102644.77470-2-pawell@cadence.com>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  drivers/usb/gadget/udc/cdns2/cdns2-gadget.h | 707 ++++++++++++++++++++
>  1 file changed, 707 insertions(+)
>  create mode 100644 drivers/usb/gadget/udc/cdns2/cdns2-gadget.h
> 

Not needed, you can drop this from all branches, thanks.

greg k-h
