Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E4FF77D4E3
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 23:09:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240107AbjHOVIo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 17:08:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240168AbjHOVIQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 17:08:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88C93F2;
        Tue, 15 Aug 2023 14:08:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1CB676591E;
        Tue, 15 Aug 2023 21:08:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04FB4C433C8;
        Tue, 15 Aug 2023 21:08:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1692133685;
        bh=ttSyse3E5HDvOSkC3moUulIHEdORrO/n+fyoNdvZy8c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iNOowhA2XsOMlOjkegTbY+lfPdfRfLmEog9XrEB1LXoX5Ehi1QgXJz9Z9hjginXrm
         83BIz6zC0lx2QseiFnTVgYXbg6Ol0dQFHPjIz/+b54QljD2nfuXxIH16/+F2h4yoay
         e1St5KByd4hQNqDRfxAa8D5FCYtPoMwK77u32q88=
Date:   Tue, 15 Aug 2023 23:08:02 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Atul Kumar Pant <atulpant.linux@gmail.com>
Cc:     stern@rowland.harvard.edu, bagasdotme@gmail.com, raychi@google.com,
        f.suligoi@asem.it, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, shuah@kernel.org
Subject: Re: [PATCH v1] drivers: usb: Replaces spaces with tabs for
 indentation.
Message-ID: <2023081515-glove-grub-96b0@gregkh>
References: <20230815204439.52137-1-atulpant.linux@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230815204439.52137-1-atulpant.linux@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 16, 2023 at 02:14:39AM +0530, Atul Kumar Pant wrote:
> This patch fixes following checkpatch.pl issue:
> ERROR: code indent should use tabs where possible
> 
> Signed-off-by: Atul Kumar Pant <atulpant.linux@gmail.com>
> ---
>  drivers/usb/core/hub.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

You didn't mention "hub" in the subject?

Again, please start out by doing work in drivers/staging/ to learn how
to write good patches, before venturing out into other areas of the
kernel.  Fixing up whitespace issues in random kernel parts is not
always encouraged.

thanks,

greg k-h
