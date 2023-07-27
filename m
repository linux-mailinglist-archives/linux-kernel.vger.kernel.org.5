Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F118764458
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 05:29:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230224AbjG0D3G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 23:29:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229819AbjG0D2n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 23:28:43 -0400
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 520F5F2;
        Wed, 26 Jul 2023 20:28:41 -0700 (PDT)
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 36R3Pwt8028003;
        Thu, 27 Jul 2023 05:25:58 +0200
Date:   Thu, 27 Jul 2023 05:25:58 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Shuah Khan <skhan@linuxfoundation.org>, linux-next@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        "Paul E. McKenney" <paulmck@kernel.org>, thomas@t-8ch.de,
        linux-kernel@vger.kernel.org, shuah <shuah@kernel.org>
Subject: Re: Request for linux-kselftest nolibc branch Inclusion in linux-next
Message-ID: <20230727032558.GA27996@1wt.eu>
References: <4a007283-be03-907a-094f-6651a44e631f@linuxfoundation.org>
 <f28bfb83-49c6-53b1-71db-aba815505af4@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f28bfb83-49c6-53b1-71db-aba815505af4@infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Randy,

On Wed, Jul 26, 2023 at 04:17:41PM -0700, Randy Dunlap wrote:
> 
> 
> On 7/24/23 15:22, Shuah Khan wrote:
> > Hi Stephen,
> > 
> > Please include the following linux-kselftest nolibc branch for linux-next
> > coverage. This will be based on Linus's tree.
> > 
> > I will be using this branch to send nolibc pull requests to Linus.
> > 
> > URL for the branch:
> > https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest.git/log/?h=nolibc
> > 
> > Primary Contacts:
> > Shuah Khan - shuah@kernel.org or Shuah Khan <skhan@linuxfoundation.org>
> > 
> > Please cc:
> > Willy Tarreau <w@1wt.eu>
> > Thomas Weiﬂschuh <thomas@t-8ch.de>
> > Paul E. McKenney <paulmck@kernel.org>
> 
> Should the MAINTAINERS file entry for NOLIBC be updated?
> (I think so.)

Yes we planned to do it and will do it soon.

Thanks,
Willy
