Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 970CA790B64
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Sep 2023 11:43:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236246AbjICJkG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Sep 2023 05:40:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229785AbjICJkF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Sep 2023 05:40:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1803136
        for <linux-kernel@vger.kernel.org>; Sun,  3 Sep 2023 02:40:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9005660A54
        for <linux-kernel@vger.kernel.org>; Sun,  3 Sep 2023 09:40:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97089C433C8;
        Sun,  3 Sep 2023 09:40:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1693734001;
        bh=sLLDzaG7f3XyGmQPkTTb8MqLp9cXNzqQeHYjomE0Hp0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CJ2VR08VxXuf6PveoHUCtCd0ON11sFpWgCVi18Io9vRlA/jRjZf1/mED4xVoS/VNj
         uHGmw4WRPVPy9uLHm6hNcLuBlEGvG/P52GYvFHjQFv0A8LIFoD2tPcB0YJBAfOcSsv
         l3tJL/QZPmAQ8ZruDNgcQUpV/sNLAz8+EEcSt1No=
Date:   Sun, 3 Sep 2023 11:39:58 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jonathan Bergh <bergh.jonathan@gmail.com>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Staging: Fixed some formatting warnings in the vme_user
 driver
Message-ID: <2023090349-fresh-empirical-425d@gregkh>
References: <20230903082253.562042-1-bergh.jonathan@gmail.com>
 <2023090324-recopy-unisexual-db41@gregkh>
 <CA+MPq=VjvQSmY_coVxrmisXavgaZa78ram-SH2pHvOZ=AvaqRQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+MPq=VjvQSmY_coVxrmisXavgaZa78ram-SH2pHvOZ=AvaqRQ@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 03, 2023 at 11:17:41AM +0200, Jonathan Bergh wrote:
> Hi Greg,
> I hope you are well. I got this response from your bot!
> I pretty much followed your FOSDEM instructions for *first kernel
> patches* so i thought I was doing it right.

That's a really old talk, things have changed a bit since then :)

> Based on the video of your talk, is more required in the SUBJECT and
> BODY for such a (basic) change? It seemed the above was pretty much
> inline with the terseness / examples you showed in your presentation.
> Hopefully thats the case.

Yes, you need a better changelog and subject line.  Read the link that
the bot referred you to and look at all of the examples commits that
have been accepted for the files that you modified to give you an idea
of what is needed.

thanks,

greg k-h
