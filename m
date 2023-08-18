Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4E197814B3
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 23:23:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240643AbjHRVWy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 17:22:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237820AbjHRVWV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 17:22:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57A6F421A;
        Fri, 18 Aug 2023 14:22:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DB9D36341E;
        Fri, 18 Aug 2023 21:22:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7D6BC433C7;
        Fri, 18 Aug 2023 21:22:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1692393739;
        bh=6RF79ZSClj1lQVSBT0ejpgM4pv7TXowmSx5NBfjobbs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hBSbsHInjlHazMciWMHxCxcAGABJuPtozyKAzAc309XhhI2hH8SUGyjkKMOoqkCK7
         GBh9mEp6wGaYEk7GqoXZqwgWARk3UQePAhaj6EGJ3z6X5Fow0aDFKCxJYgE1RRlEKj
         pTcmtJxTeqfM03kOH+A7zJyBAPglJ/xjdw2rN7CA=
Date:   Fri, 18 Aug 2023 23:22:15 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-serial@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 1/3] Documentation: devices.txt: Remove ttyIOC*
Message-ID: <2023081806-bobtail-donut-f0a3@gregkh>
References: <b5deb1222eb92017f0efe5b5cae127ac11983b3d.1691992627.git.christophe.leroy@csgroup.eu>
 <87il9cl00v.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87il9cl00v.fsf@meer.lwn.net>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 18, 2023 at 11:42:56AM -0600, Jonathan Corbet wrote:
> Christophe Leroy <christophe.leroy@csgroup.eu> writes:
> 
> > IOC4 serial driver was removed, remove associated devices
> > from documentation.
> >
> > Fixes: a017ef17cfd8 ("tty/serial: remove the ioc4_serial driver")
> > Cc: Christoph Hellwig <hch@lst.de>
> > Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> > ---
> >  Documentation/admin-guide/devices.txt | 9 ---------
> >  1 file changed, 9 deletions(-)
> 
> This doesn't apply to docs-next, seemingly as the result of a change
> that went through Greg's tree, so these should follow the same path,
> methinks.

I'll be glad to take it, thanks.

greg k-h
