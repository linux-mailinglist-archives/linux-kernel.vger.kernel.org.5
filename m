Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED54F76A635
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 03:22:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231720AbjHABVc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 21:21:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229661AbjHABVa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 21:21:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7197A1704
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 18:21:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0E16461375
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 01:21:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F02D7C433C8;
        Tue,  1 Aug 2023 01:21:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690852888;
        bh=gZq2C/GVYvLDKVT/9oQ/tc2BeAoPIrbCRPRE9OxNO4g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bKTpVTKNPWm3YmZ4N45FDecL3jt6iC7xcA3zIgHfxl2qY1ZuLctwB/5v24I+BkDix
         DrsOcoKZ47EMHFx8gQnTiPUORhA9+HjzeIZjqTnc/dM9Huti5jf8T8DFGIj1gbnAg+
         jQuQFzK8lls/wvHlXBr8jzmF+uKTNvCi259gf2xrnbJ8ZtnkUQDWUt3LHoY8TVW9Rx
         T9uXk3bHTuiyr6nw20rFe6n+hqT85Ofo5WSZujuSMXiThy8Epfj0i1nRZJUYScc+xV
         7F4GSJ2xnpGk6+wDwHH/++3m/u0E0bkwALc+JIckM89wdIGggVTw987W/lKimg4bcJ
         YN4VOZC+W3RFQ==
From:   SeongJae Park <sj@kernel.org>
To:     SeongJae Park <sj@kernel.org>
Cc:     damon@lists.linux.dev, linux-damon@amazon.com,
        linux-damon-trial@amazon.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: DAMON Beer/Coffee/Tea chat series
Date:   Tue,  1 Aug 2023 01:21:26 +0000
Message-Id: <20230801012126.6249-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220810225102.124459-1-sj@kernel.org>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello community,

On Wed, 10 Aug 2022 22:51:02 +0000 SeongJae Park <sj@kernel.org> wrote:

> Hello,
> 
> 
> In short, I'd like to start an open, regular, and informal virtual bi-weekly
> meeting series for DAMON community.
> 
> Important links and dates
> -------------------------
> 
> Location: https://meet.google.com/ndx-evoc-gbu
> Agenda: https://docs.google.com/document/d/1v43Kcj3ly4CYqmAkMaZzLiM2GEnWfgdGbZAH3mi2vpM/edit?usp=sharing

I'm gonna be out of office from mid of August to end of OSSummit Euro 2023[1],
partly for preparation of my OSSummit Euro talk[2].  For the reason, I will not
be able to schedule and attend the DAMON beer/coffee/tea meeting during the
time.  I will still be reachable, though I might be less responsive during the
period.

Also, looking forward to meet some of you who will attend the conference! :)

[1] https://events.linuxfoundation.org/open-source-summit-europe/
[2] https://sched.co/1OGf9


Thanks,
SJ
