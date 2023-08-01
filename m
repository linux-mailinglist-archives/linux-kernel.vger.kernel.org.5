Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 324CD76A64C
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 03:27:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231363AbjHAB1Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 21:27:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229725AbjHAB1V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 21:27:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D22F2114
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 18:27:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 66ED76134A
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 01:27:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55DDEC433C8;
        Tue,  1 Aug 2023 01:27:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690853239;
        bh=KWIHlUVq7RPoPIKoVzh0uWwNJse5bLl7z8vrM8catMI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=u7b0rr8NvKmQ9NDsv5DtBNC2+bvGCI5rXPEo52cH1G9kbxkYf0bli+EPpwHMUqSiz
         FqBQJW6KIxJcsWr3UOXcqWpLsqRqgqm+JSxjDmhhdFa2jr+2EdmufSjWOM7NYY5MST
         awW7OyNfS4HhdV71Uf46fWWW1RsgH0saP9Mv1K9t6YxTe1pCUFJTP98uRReSSV9eRY
         +Vq32ZVxPSbaQxa9kREllXZ5mWPyl98js34I14vz8UMHC9i1wdHMc+f/zXH8cqto2o
         XWCwcKfDu9++KuIblz/mfX3Qid4Q8vOhvZVDWSKtedskym9YS6tItdvHmdSAqvq1aI
         hq4DI6JTkq3ZA==
From:   SeongJae Park <sj@kernel.org>
To:     SeongJae Park <sj@kernel.org>
Cc:     damon@lists.linux.dev, linux-damon@amazon.com,
        linux-damon-trial@amazon.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: DAMON Beer/Coffee/Tea chat series
Date:   Tue,  1 Aug 2023 01:27:17 +0000
Message-Id: <20230801012718.6312-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230801012126.6249-1-sj@kernel.org>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 1 Aug 2023 01:21:26 +0000 SeongJae Park <sj@kernel.org> wrote:

> Hello community,
> 
> On Wed, 10 Aug 2022 22:51:02 +0000 SeongJae Park <sj@kernel.org> wrote:
> 
> > Hello,
> > 
> > 
> > In short, I'd like to start an open, regular, and informal virtual bi-weekly
> > meeting series for DAMON community.
> > 
> > Important links and dates
> > -------------------------
> > 
> > Location: https://meet.google.com/ndx-evoc-gbu
> > Agenda: https://docs.google.com/document/d/1v43Kcj3ly4CYqmAkMaZzLiM2GEnWfgdGbZAH3mi2vpM/edit?usp=sharing
> 
> I'm gonna be out of office from mid of August to end of OSSummit Euro 2023[1],
> partly for preparation of my OSSummit Euro talk[2].  For the reason, I will not
> be able to schedule and attend the DAMON beer/coffee/tea meeting during the
> time.  I will still be reachable, though I might be less responsive during the
> period.

FYI, we will have one more meeting before that, on 2023-08-08.  And the regular
series will restart from 2023-09-26.  Updated the google doc.

> 
> Also, looking forward to meet some of you who will attend the conference! :)

And, hopefully we can have a small but physical version of Beer/Coffee/Tea
meeting there!  Feel free to ask me for a beer if you find me ;)


Thanks,
SJ

> 
> [1] https://events.linuxfoundation.org/open-source-summit-europe/
> [2] https://sched.co/1OGf9
> 
> 
> Thanks,
> SJ
