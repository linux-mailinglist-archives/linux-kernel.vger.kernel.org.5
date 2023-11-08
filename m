Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F30C7E5988
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 15:55:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232328AbjKHOzp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 09:55:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230139AbjKHOzn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 09:55:43 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E63F51BDD
        for <linux-kernel@vger.kernel.org>; Wed,  8 Nov 2023 06:55:41 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77EEEC433C7;
        Wed,  8 Nov 2023 14:55:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699455341;
        bh=SyHUGqhq5GhN6Gpzy5MDudMqRL6roYzi8hTlHcwugmM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:From;
        b=lHZKEOBFK/+KyUgKy1aQ3b8vedxJ775eRg4e5saOWvKQdUvFxW3rfhZ+IBVMKffmB
         dBqbkhk8TaX+o8WjpFezjXkjKRQJxztFflyveEgVoqt4zX5gmWaHXi2z04/ZxTYNIc
         2woteo23i+eMysuMeAQR68NJygYbLyJypqb2C4gKtgwPzu/90zC+t/nwL3YSs8KSsJ
         lJfvKNuJocQ17kqPT9YZzFYQNhRoy6H8OJwAAmwgVEy0B4bc9QXvXzSgQnIKWACSWn
         ZrZ2/zvGoHc/i08rfwnpH7NGbQaoZRkX8wul3UeQ+mV5qSGKNVQxWiOiPOmUV/8FHf
         m6VUqowYy6P5g==
From:   SeongJae Park <sj@kernel.org>
To:     SeongJae Park <sj@kernel.org>
Cc:     damon@lists.linux.dev, linux-damon@amazon.com,
        linux-damon-trial@amazon.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: DAMON Beer/Coffee/Tea chat series
Date:   Wed,  8 Nov 2023 06:55:25 -0800
Message-Id: <20231108145525.12650-1-sj@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220909173856.55818-1-sj@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Community,

On Fri, 9 Sep 2022 17:38:56 +0000 SeongJae Park <sj@kernel.org> wrote:

> Hello,
> 
> On Tue, 30 Aug 2022 21:54:28 +0000 SeongJae Park <sj@kernel.org> wrote:
> 
> > Hello,
> > 
> > On Wed, 10 Aug 2022 22:51:02 +0000 SeongJae Park <sj@kernel.org> wrote:
> > 
> > > Hello,
> > > 
> > > 
> > > In short, I'd like to start an open, regular, and informal virtual bi-weekly
> > > meeting series for DAMON community.
> > > 
> > > Important links and dates
> > > -------------------------
> > > 
> > > Location: https://meet.google.com/ndx-evoc-gbu
> > > Agenda: https://docs.google.com/document/d/1v43Kcj3ly4CYqmAkMaZzLiM2GEnWfgdGbZAH3mi2vpM/edit?usp=sharing
> > > 
> > > First instance: 2022-08-15 18:00 PDT
> > > Second instance: 2022-08-30 09:00 PDT
[...]
> 
> And I just received the acceptance notification of my BoF proposal.  The
> schedule is not updated yet, but I guess it should be 2022-09-14 (Wednesday)
> 17:00-18:30 in Irish Standard Time (IST, UTC+01:00, Europe/Dublin timezone).
> So, our next DAMON Beer/Coffee/Tea Chat series will be held in LPC2022, in
> person.  I will update the final time and location as soon as possible.

Like the last year, DAMON BoF at LPC has accepted and scheduled[1].  So we will
have the second in-person DAMON community meetup (a.k.a Beer/Coffee/Tea Chat)!
The schedule is Wednesday 4:30 PM, EST.  I hope it to be the place to meet with
community members, say hi to each other, and discuss any interesting things.
Since that's the close to the end of the conference, it could also be a good
place to say good bye to each other :)

Of course, please don't wait until the time slot if you have anything want to
ask to, or discuss with me.  If you find me on the hall, I'm yours :)

Please also note that I'll have a talk about DAMON status and plans[2] at
kernel summit.  The talk will start 2:30 PM, EST, of the same day (Wednesday).
So if I fail at time managing again and therefore if your question is not
answered, the BoF will be a nice place for that.

Looking forward to meet you all!

[1] https://lpc.events/event/17/contributions/1652/
[2] https://lpc.events/event/17/contributions/1624/


Thanks,
SJ

[...]
