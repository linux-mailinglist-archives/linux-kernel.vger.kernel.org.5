Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB3D67CFB0A
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 15:31:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345800AbjJSNbS convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 19 Oct 2023 09:31:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235350AbjJSNbQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 09:31:16 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C30B11B
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 06:31:14 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7922C433C7;
        Thu, 19 Oct 2023 13:31:10 +0000 (UTC)
Date:   Thu, 19 Oct 2023 09:31:09 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     David Vernet <void@manifault.com>
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, bsegall@google.com, bristot@redhat.com,
        vschneid@redhat.com, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@kernel.org, joshdon@google.com, brho@google.com,
        pjt@google.com, derkling@google.com, haoluo@google.com,
        youssefesmat@google.com, greg.marsden@oracle.com,
        willy@infradead.org, andrea.righi@canonical.com,
        andrealmeid@igalia.com, changwoo@igalia.com, gpiccoli@igalia.com,
        tj@kernel.org, colin.i.king@gmail.com, ast@kernel.org,
        julia.lawall@inria.fr, himadrispandya@gmail.com,
        redha.gouicem@rwth-aachen.de, admin@ptr1337.dev,
        lucjan.lucjanov@gmail.com
Subject: Re: Sched Ext slack channel / office hours
Message-ID: <20231019093109.4c4406b2@gandalf.local.home>
In-Reply-To: <20231018205431.GA4176@maniforge>
References: <20231018205431.GA4176@maniforge>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 Oct 2023 15:54:31 -0500
David Vernet <void@manifault.com> wrote:

> Hello everyone,
> 
> The first RFC patch set [0] for sched_ext was sent to the upstream list
> almost one year ago, with three more revisions of the series having been
> sent upstream since. In that time, a number of individuals, companies,
> and organizations have begun to use and experiment with sched_ext. We
> want to make it easier to collaborate, so we’ve decided to set up a
> weekly office hours call, and create a Slack channel [1] that folks can
> join to ask questions, discuss features, etc.
> 
> [0]: https://lore.kernel.org/lkml/20221130082313.3241517-1-tj@kernel.org/
> [1]: https://join.slack.com/t/schedextworkspace/shared_invite/zt-24c4on3sk-sHlozdLfCZBODfwU6t6dbw
> 
> The Slack channel can be joined via the link in [1]. For office hours,
> we’ll start with 10:00 PDT / 17:00 UTC on Mondays (likely starting the
> week of 10/30), but we can change the time if it’s inconvenient for too
> many folks. The calls will likely take place through Slack, so you’ll
> have to join the Slack channel if you want to participate in the office
> hours calls. As a friendly reminder, you can access the sched_ext
> repository at [2].
> 
> [2]: https://github.com/sched-ext/sched_ext

I just have to state that there's a significant amount of people on this
list (myself included) that will not use slack (I don't have it installed
on any of my machines, and will not install it). Perhaps an open source
platform (matrix) or simply an IRC channel would work for us. Although that
still would not guarantee that anyone would show up.

That said, I do host a Linux schedule monthly meeting on Google meets if
you would like to join that.

-- Steve
