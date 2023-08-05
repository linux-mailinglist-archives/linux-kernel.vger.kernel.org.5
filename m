Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F4D4770E22
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Aug 2023 08:35:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229687AbjHEGf5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Aug 2023 02:35:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjHEGfz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Aug 2023 02:35:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17936FC;
        Fri,  4 Aug 2023 23:35:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AA7EC602E4;
        Sat,  5 Aug 2023 06:35:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B400EC433C8;
        Sat,  5 Aug 2023 06:35:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691217353;
        bh=F79EDj5kRKp/N9ma2AKYe37YB8vitW2dtsRvp4XZdWY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=n3rncTO9i7xC7nMuioWr4R7eqBadJKNi7KI27UHhMJjjVauznDSqPqp8EYXR130wZ
         fLau+DmZ6+flrNPHQe18dKLP66uwtg4wuUFckf9UaGGAMHyeEE7euQP6qdTWaacsHq
         2qxXVRK2DnSzKRZ0o2y83bWeWk2PPEQbALAF24fc=
Date:   Sat, 5 Aug 2023 08:35:44 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Georgi Djakov <djakov@kernel.org>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] interconnect fixes for 6.5-rc
Message-ID: <2023080533-twisted-legwarmer-a943@gregkh>
References: <20230804164549.3407394-1-djakov@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230804164549.3407394-1-djakov@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 04, 2023 at 07:45:49PM +0300, Georgi Djakov wrote:
> Hello Greg,
> 
> This pull request contains fixes for the current cycle. The details are
> in the signed tag. All patches have been in linux-next during the last
> few weeks! Please pull into char-misc-linus when you get a chance.
> 
> Thanks,
> Georgi
> 
> 
> The following changes since commit 06c2afb862f9da8dc5efa4b6076a0e48c3fbaaa5:
> 
>   Linux 6.5-rc1 (2023-07-09 13:53:13 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/djakov/icc.git tags/icc-6.5-rc5

Pulled and pushed out, thanks.

greg k-h
