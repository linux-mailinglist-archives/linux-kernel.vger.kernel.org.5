Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9834775ED7
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 14:24:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232266AbjHIMYb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 08:24:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231426AbjHIMY3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 08:24:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38F491BF7
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 05:24:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CD18B63871
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 12:24:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDD22C433C9;
        Wed,  9 Aug 2023 12:24:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691583868;
        bh=RWBM/7u/Y6B3ImXjjtu9fLXip7UdWbgFzjOKNj6psf8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=R077qVQ8N36/m2Uf60uAGnaCT7f70A8CaZ0QdA85SZCC9KMDRTaGgBxaS1MZGkbuL
         p5HlSKUVxBVYfESLdPz5N29bNWI6LGkEdo4TNig/SlrahlIi0w78cl4DEGbGsG7VDI
         rbuf2YJ510WXebJyQqJ4f5FvZLtgvMjE9akIa3Hw=
Date:   Wed, 9 Aug 2023 14:24:25 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Alexon Oliveira <alexondunkan@gmail.com>
Cc:     martyn@welchs.me.uk, manohar.vanga@gmail.com,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: Re: [PATCH v3] staging: vme_user: fix alignment of open parenthesis
 and deleted trailing spaces
Message-ID: <2023080902-cattle-disparate-6b82@gregkh>
References: <ZNJKTLZ62SZMM6D8@alolivei-thinkpadt480s.gru.csb>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZNJKTLZ62SZMM6D8@alolivei-thinkpadt480s.gru.csb>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 08, 2023 at 10:59:40AM -0300, Alexon Oliveira wrote:
> Fixed all CHECK: Alignment should match open parenthesis
> and deleted the trailing whitespaces as reported by
> checkpatch to adhere to the Linux kernel coding-style
> guidelines.
> 
> Signed-off-by: Alexon Oliveira <alexondunkan@gmail.com>
> ---
> 
> Changes in v3:
> - Rebased against staging.git and staging-next branch, noted by Greg KH

I don't think you did this as it still fails to apply for me :(

Can you go through the exact steps and try again?

thanks,

greg k-h
