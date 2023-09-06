Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07A1C793797
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 11:00:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229921AbjIFJAp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 05:00:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbjIFJAo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 05:00:44 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23E5B197
        for <linux-kernel@vger.kernel.org>; Wed,  6 Sep 2023 02:00:40 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1138C433C9;
        Wed,  6 Sep 2023 09:00:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693990839;
        bh=dccYAb8NZw586jYwNMxtJDkvCPAE9J8nhTUnIUwcsXc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ahWyxmcQACTVzTCGKPWUsZWZzRW4frPiOD2wqVjz5XDP/XdeYqwlx3AtQFvkg0wYe
         4jTB17KblH8mJ3UTQ0n1wIzc3HqH428mhB2eg+NNwF2mUUNHUVNZW3269fxY6WVtff
         Y/+eJr3YRuZrHCM8P7y76dU/boRRAc8YzDpfWZBThM7PKmWvq/9kpi97lMPMt3WOXQ
         DKj3ghdOuFdjajlD+1o6NCJqSwKJoql88NnaksKnYtquq3cGxDjoUb/Xc5K1YVpMbF
         YraBT6Q5PaPO4TbViZ7/IdewkNZyNuAFlfuOJ+xIa09onFeZVnMjW0GUdD26XN41Oi
         4D2jVauYOWWIw==
Date:   Wed, 6 Sep 2023 10:00:35 +0100
From:   Lee Jones <lee@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Daniel Thompson <daniel.thompson@linaro.org>
Subject: Re: [GIT PULL] Backlight for v6.6
Message-ID: <20230906090035.GI13143@google.com>
References: <20230904141139.GC13143@google.com>
 <CAHk-=wjrLwir-97uT+bX7Y-D3qs3qfkz0BKVj=SrXT6vNeBPvw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHk-=wjrLwir-97uT+bX7Y-D3qs3qfkz0BKVj=SrXT6vNeBPvw@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 04 Sep 2023, Linus Torvalds wrote:

> On Mon, 4 Sept 2023 at 07:11, Lee Jones <lee@kernel.org> wrote:
> >
> >   git://git.kernel.org/pub/scm/linux/kernel/git/lee/backlight.git backlight-next-6.6
> 
> -ENOSUCHTAG.
> 
> Forgot to push?

Looks that way.  Please -EAGAIN.

-- 
Lee Jones [李琼斯]
