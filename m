Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2542875C6A7
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 14:12:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231220AbjGUMMF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 08:12:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229801AbjGUMME (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 08:12:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26D89171B;
        Fri, 21 Jul 2023 05:12:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B3DB261A32;
        Fri, 21 Jul 2023 12:12:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C9F4C433C8;
        Fri, 21 Jul 2023 12:12:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689941522;
        bh=6uuSVML+VGcI+K4MjLj14Q9omAIcvUfGjfNAfgE7RN4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fg+fqDOHASh9qIjRc3dS8iVHh6H5M+ML2jSHWiZLrHZsd+DVBXrl61+HvYQqK1VVM
         UfK12nDSm2mSgRDfvovoAnGvZcaVjLRNqKJXGW8VpRZP2bwJPoYfD6eOKI0zi9sVyg
         VLWt+ONlFapYvwWwzY+uyZMkzyN3oEIx75kUxIqA=
Date:   Fri, 21 Jul 2023 14:11:59 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Dingyan Li <18500469033@163.com>
Cc:     stern@rowland.harvard.edu, sebastian.reichel@collabora.com,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Re: [PATCH] USB: add usbfs ioctl to get specific superspeedplus
 rates
Message-ID: <2023072126-shuffle-lifter-394f@gregkh>
References: <20230721084039.9728-1-18500469033@163.com>
 <2023072105-lethargic-saddling-ad97@gregkh>
 <550dbb46.5bc4.189785b0360.Coremail.18500469033@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <550dbb46.5bc4.189785b0360.Coremail.18500469033@163.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 21, 2023 at 08:09:37PM +0800, Dingyan Li wrote:

<snip?

For some reason your email client responded in html form, which is
rejected by the mailing lists.  Please fix up your email client and
resend it and I will be glad to respond.

thanks,

greg k-h
