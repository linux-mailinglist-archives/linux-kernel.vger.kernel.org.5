Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 907857FE190
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 22:10:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234328AbjK2VJ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 16:09:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234168AbjK2VJ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 16:09:58 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D649D67
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 13:10:05 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73C8DC433C7;
        Wed, 29 Nov 2023 21:10:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1701292204;
        bh=aQe3X0+1WsGBf/QVwG5GwFOfFHLsTEKPmwIkORCnfx0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=yhfdZbj/Z4TOtnn6qPw+K98272UCT4HB3++xpWlLLB/paoWhN0xilv+/lRB6ArTm8
         AjJuSfhMaeseyvikeqVgRaajzRokKW8m5LxLh+Ktxm/H+QoFeF3B1b140yRJhYHfCa
         aM0LAiRIW427lotpgjLAFisdNxnDC1gUqMZeU0GA=
Date:   Wed, 29 Nov 2023 13:10:03 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Stephen Rothwell <sfr@rothwell.id.au>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: lots of errors/warnings from the
 -Werror=missing-prototypes addition
Message-Id: <20231129131003.d2c1078847c3865c1ac2dfd5@linux-foundation.org>
In-Reply-To: <20231130075838.05e5bc9b@oak>
References: <20231130075838.05e5bc9b@oak>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 Nov 2023 07:58:38 +1100 Stephen Rothwell <sfr@rothwell.id.au> wrote:

> Hi all,
> 
> please see the kernelci results here:
> 
> https://lore.kernel.org/all/656732fc.170a0220.49447.2c19@mx.google.com/

And I'm not seeing a lot of fixing activity for these.  Arnd, do you
think it was just too soon?
