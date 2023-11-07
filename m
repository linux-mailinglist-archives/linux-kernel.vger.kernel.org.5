Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 026CF7E35B6
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 08:20:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233481AbjKGHUT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 02:20:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbjKGHUS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 02:20:18 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A3D410A
        for <linux-kernel@vger.kernel.org>; Mon,  6 Nov 2023 23:20:16 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79DFFC433C8;
        Tue,  7 Nov 2023 07:20:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1699341616;
        bh=zE6s17byWtutyeorY6k2ptjknyn3c3xKtGwM/S9QtA8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oE0jf3TybdxyISxQ2xWJm2D7gPVHLu4owV39NP9b/0p1yt6VGaq30Y24hg6X8G2ON
         T3Z4srTOib2rAd42EVyOmAa2bNn2GJRKxJuOv5jTtMsTzr33zIuPtf9CLRv8VDh6YS
         y1U4P8OD2Gw5ZL/h1elfni1/9qKzMwOZ2Lnv3Lnk=
Date:   Tue, 7 Nov 2023 08:20:12 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Vaibhav Gupta <vaibhavgupta40@gmail.com>
Cc:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Jens Taprogge <jens.taprogge@taprogge.org>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        industrypack-devel@lists.sourceforge.net
Subject: Re: [PATCH] ipack: Remove usage of the deprecated ida_simple_xx() API
Message-ID: <2023110759-strewn-although-b56f@gregkh>
References: <435bd17b8a5ddb2fc3e42e2796117ee02263d02a.1698831664.git.christophe.jaillet@wanadoo.fr>
 <CAP+cEOOEmbgon-VjUQtVBVXDcsgmJ1EZr7p=kqt04eUE3D9TeA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP+cEOOEmbgon-VjUQtVBVXDcsgmJ1EZr7p=kqt04eUE3D9TeA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 07, 2023 at 08:04:45AM +0100, Vaibhav Gupta wrote:
> Hello Christophe,
> Thank you for your patch.
> 
> Acked-by: Vaibhav Gupta <vaibhavgupta40@gmail.com>
> 
> Hey Greg, could you please add this patch to your misc tree?

Will do after -rc1 is out.
