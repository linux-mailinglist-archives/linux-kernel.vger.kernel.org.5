Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63D6B783D56
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 11:51:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234502AbjHVJvL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 05:51:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232971AbjHVJvK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 05:51:10 -0400
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 21A551B2;
        Tue, 22 Aug 2023 02:51:03 -0700 (PDT)
Received: (from willy@localhost)
        by mail.home.local (8.17.1/8.17.1/Submit) id 37M9oC8O023548;
        Tue, 22 Aug 2023 11:50:12 +0200
Date:   Tue, 22 Aug 2023 11:50:12 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas@t-8ch.de>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: duplicate patch in the nolibc tree
Message-ID: <ZOSE1GoBrrqvBc0i@1wt.eu>
References: <20230817133811.0a73c624@canb.auug.org.au>
 <e0af8d82-e099-49fa-9fbd-6f6bb63b7706@t-8ch.de>
 <9cfb4fe4-162b-3f26-646b-71bed3493925@linuxfoundation.org>
 <4c037ef2-9159-4528-8ecb-8596cb2a3889@paulmck-laptop>
 <20230817193909.GA30505@1wt.eu>
 <01d517c4-d91b-4426-b7f2-2b1277f21d8c@paulmck-laptop>
 <20230818-anblicken-mitinhaber-11cd07cce0a1@brauner>
 <e08e3dd5-48b8-5da2-5d0c-7d5b70a9e9be@linuxfoundation.org>
 <6822c914-4f11-be93-ed55-56447a5838f9@linuxfoundation.org>
 <20230821-raven-abreibung-cc4abe44c9f5@brauner>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230821-raven-abreibung-cc4abe44c9f5@brauner>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Aug 21, 2023 at 06:07:45PM +0200, Christian Brauner wrote:
> > We will go to our plan b of having Willy drop the patch, resend the
> > pull request to me ....
> 
> No, I didn't drop it so I appreciate it if you went with your plan.
> If I drop it now I'd be causing churn after having this sit in -next for
> over 5 weeks and I'll send a pr in the middle of this week.

I personally don't care about dropping it, but the whole process is
unclear to me and I'm unsure about what I can/have to do if at all
to help here.

Thanks,
Willy
