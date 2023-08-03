Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AA1E76F348
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 21:16:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230430AbjHCTQF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 15:16:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229829AbjHCTPp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 15:15:45 -0400
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E786130EB
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 12:15:40 -0700 (PDT)
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 373JFXbr025284;
        Thu, 3 Aug 2023 21:15:33 +0200
Date:   Thu, 3 Aug 2023 21:15:33 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
        linux-kernel@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Subject: Re: [PATCH] MAINTAINERS: nolibc: add myself as co-maintainer
Message-ID: <20230803191533.GA25279@1wt.eu>
References: <20230728-nolibc-maintainer-v1-1-5f13daaebf4c@weissschuh.net>
 <1f85e8c3-e07d-482f-aa90-5e6631bc7873@t-8ch.de>
 <884b4415-2b6f-44be-aaeb-da1d9d85ea01@paulmck-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <884b4415-2b6f-44be-aaeb-da1d9d85ea01@paulmck-laptop>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 03, 2023 at 11:43:17AM -0700, Paul E. McKenney wrote:
> On Thu, Aug 03, 2023 at 08:31:50PM +0200, Thomas Weißschuh wrote:
> > Hi Paul, 
> > 
> > On 2023-07-28 23:21:52+0200, Thomas Weißschuh wrote:
> > > As discussed with Willy, Paul and Shuah add myself as maintainer for
> > > the nolibc subsystem.
> > 
> > it seems I forgot to send the nolibc maintainers update patch to you.
> > 
> > My bad!
> > 
> > Willy and me wondered if the patch could go through your tree?
> 
> It could, but why not just include it in the batch going to Shuah?
> It is not all that long until the merge window opens, plus it is hard
> to argue that this is a regression.

OK, I'll take it in my queue and send everything at once to Shuah.
Thomas and I didn't know if the file had to be updated quickly or
not.

Thanks!
Willy
