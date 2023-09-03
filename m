Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F07A790B33
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Sep 2023 10:17:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235223AbjICIRm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Sep 2023 04:17:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233751AbjICIRm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Sep 2023 04:17:42 -0400
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9163A189
        for <linux-kernel@vger.kernel.org>; Sun,  3 Sep 2023 01:17:35 -0700 (PDT)
Received: (from willy@localhost)
        by mail.home.local (8.17.1/8.17.1/Submit) id 3838H9TT027927;
        Sun, 3 Sep 2023 10:17:09 +0200
Date:   Sun, 3 Sep 2023 10:17:09 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     Ammar Faizi <ammarfaizi2@gnuweeb.org>
Cc:     Alviro Iskandar Setiawan <alviro.iskandar@gnuweeb.org>,
        Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
        David Laight <David.Laight@aculab.com>,
        Nicholas Rosenberg <inori@vnlx.org>,
        Michael William Jonathan <moe@gnuweeb.org>,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH v3 2/4] tools/nolibc: x86-64: Use `rep stosb` for
 `memset()`
Message-ID: <ZPRBBT1ENJIB0cEp@1wt.eu>
References: <20230902133505.2176434-1-ammarfaizi2@gnuweeb.org>
 <20230902133505.2176434-3-ammarfaizi2@gnuweeb.org>
 <CAOG64qNB+aRU+8VCD5MkM4srQaUnTqzZ7rZ8USxVheDAYzgTsQ@mail.gmail.com>
 <ZPOOPjK+z847Ivq4@biznet-home.integral.gnuweeb.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZPOOPjK+z847Ivq4@biznet-home.integral.gnuweeb.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NO_DNS_FOR_FROM,
        T_SPF_HELO_TEMPERROR,T_SPF_TEMPERROR autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 03, 2023 at 02:34:22AM +0700, Ammar Faizi wrote:
> On Sun, Sep 03, 2023 at 02:28:18AM +0700, Alviro Iskandar Setiawan wrote:
> > nit: Be consistent. Use \n\t for the memset too.
> 
> Good catch, I'll fix that in v4 revision.

Ammar, I'm overall fine with your series. I can as well add the missing \t
to your patch while merging it, or wait for your v4, just let me know.

Thanks,
Willy
