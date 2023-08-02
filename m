Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46CEF76CBAD
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 13:23:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234201AbjHBLXN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 07:23:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233626AbjHBLXJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 07:23:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 007E1E70
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 04:23:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8AE2861934
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 11:23:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4876CC433C7;
        Wed,  2 Aug 2023 11:23:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690975387;
        bh=L17XgsK2Eof6lFekvWAU6RnxlreNQu1PNkDYYq3t3MU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ArBQE+ZqDXoklKT6+z25xyRHt9MUkBHarGVyF4ryUEwbkjRou4pa71IXBBgoyy07q
         O0mNlldhBcksHwmNOIdfRwGF4/5QGW8VOxZbNODEA1NKMPY4lbUxj6t/yRd9X8J6IR
         Y1MGVmTdEY9AmbFqASMNwb53P9WlOWi2ElHsd8vwqHl1AxRBCgVOQNgzFSyjiBTs/H
         Yit1YKxwOUUlGEhbyH4M4bzHj2olkQlXl4qKwJCIwN6JlMNlove9jk93lFcqtSNH07
         bKFoUE2TMIcDZg6HswzyxkmAnuQhDTzHm8ePtnEPX8xXa94nVjlFONYmbQBcIIwjak
         Ea0Nqe5dDySOA==
Date:   Wed, 2 Aug 2023 16:52:54 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Jeffrey Hugo <quic_jhugo@quicinc.com>
Cc:     andersson@kernel.org, mhi@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] docs: ABI: sysfs-bus-mhi: Update contact info
Message-ID: <20230802112254.GH57374@thinkpad>
References: <20230628182346.3855-1-quic_jhugo@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230628182346.3855-1-quic_jhugo@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 28, 2023 at 12:23:46PM -0600, Jeffrey Hugo wrote:
> @codeaurora.org email addresses are no longer valid and will bounce to
> sender.  Also, Bhaumik has previously indicated he is no longer interested
> in participating in MHI bus discussions.
> 
> Update contact info from Bhaumik to the mhi mail list so that mails will
> be routed to the MHI maintainers and interested parties.
> 
> Signed-off-by: Jeffrey Hugo <quic_jhugo@quicinc.com>

Applied to mhi-next!

- Mani

> ---
>  Documentation/ABI/stable/sysfs-bus-mhi | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/ABI/stable/sysfs-bus-mhi b/Documentation/ABI/stable/sysfs-bus-mhi
> index 96ccc3385a2b..1a47f9e0cc84 100644
> --- a/Documentation/ABI/stable/sysfs-bus-mhi
> +++ b/Documentation/ABI/stable/sysfs-bus-mhi
> @@ -1,7 +1,7 @@
>  What:		/sys/bus/mhi/devices/.../serialnumber
>  Date:		Sept 2020
>  KernelVersion:	5.10
> -Contact:	Bhaumik Bhatt <bbhatt@codeaurora.org>
> +Contact:	mhi@lists.linux.dev
>  Description:	The file holds the serial number of the client device obtained
>  		using a BHI (Boot Host Interface) register read after at least
>  		one attempt to power up the device has been done. If read
> @@ -12,7 +12,7 @@ Users:		Any userspace application or clients interested in device info.
>  What:		/sys/bus/mhi/devices/.../oem_pk_hash
>  Date:		Sept 2020
>  KernelVersion:	5.10
> -Contact:	Bhaumik Bhatt <bbhatt@codeaurora.org>
> +Contact:	mhi@lists.linux.dev
>  Description:	The file holds the OEM PK Hash value of the endpoint device
>  		obtained using a BHI (Boot Host Interface) register read after
>  		at least one attempt to power up the device has been done. If
> -- 
> 2.40.1
> 
> 

-- 
மணிவண்ணன் சதாசிவம்
