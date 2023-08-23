Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D8BC7850CA
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 08:49:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233004AbjHWGtc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 02:49:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229932AbjHWGtb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 02:49:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBDB7C7
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 23:49:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 54DAE60AF0
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 06:49:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24840C433C7;
        Wed, 23 Aug 2023 06:49:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1692773368;
        bh=TCyII1sw1DT4Dy8tv/bVcCUwpjPGev1c+kC0FfES710=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hm+Qq3XxNzkxghSp+nHCOaaFpX0biVs/K+hTNFF532cltV0IkQ+nh5HcgthHhwq7p
         dOhuCCDVxcvW+yRNTH+XW2pw/z4hOPC9zDMPqk5N2732+++upwI7Bl5FQdZoT/UlQh
         TAkZMCPfrzV8M/AGeCWx9I2yFZ8t4Yf1O9V7Nizk=
Date:   Wed, 23 Aug 2023 08:49:25 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Alexon Oliveira <alexondunkan@gmail.com>
Cc:     martyn@welchs.me.uk, manohar.vanga@gmail.com,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: Re: [PATCH] staging: vme_user: fix check unbalaced braces and
 misspellings
Message-ID: <2023082303-balmy-bucktooth-f85b@gregkh>
References: <ZOVjfKUWsSAkbpZG@alolivei-thinkpadt480s.gru.csb>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZOVjfKUWsSAkbpZG@alolivei-thinkpadt480s.gru.csb>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 22, 2023 at 10:40:12PM -0300, Alexon Oliveira wrote:
> Fixed all CHECK: Unbalanced braces around else statement,
> CHECK: braces {} should be used on all arms of this statement,
> and CHECK: 'specificed' may be misspelled - perhaps 'specified'?
> as reported by checkpatch to adhere to the Linux kernel
> coding-style guidelines.

That's two different things, so that means it should be two different
patches.  Please send a patch series for this.

thanks,

greg k-h
