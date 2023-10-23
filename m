Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE62F7D3F77
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 20:46:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231609AbjJWSqO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 14:46:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231256AbjJWSqK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 14:46:10 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 685D5100
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 11:46:08 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA1BAC433C8;
        Mon, 23 Oct 2023 18:46:04 +0000 (UTC)
Date:   Mon, 23 Oct 2023 14:46:03 -0400
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
Message-ID: <20231023144603.1e18b8bf@gandalf.local.home>
In-Reply-To: <20231023175326.GA4055@maniforge>
References: <20231018205431.GA4176@maniforge>
        <20231019093109.4c4406b2@gandalf.local.home>
        <20231023175326.GA4055@maniforge>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 23 Oct 2023 12:53:26 -0500
David Vernet <void@manifault.com> wrote:

> Yes, it could be beneficial to attend your meeting as well. Please feel
> free to send us an invitation to any instance of your meeting that is
> related to sched_ext.

It's a very informal meeting and the agenda is usually created at the
meeting. So there will never be a "we are going to talk about sched_ext".
If that topic comes up, it will be because the people there want to talk
about it. The people that usually attend are:

 Myself
 Juri Lelli
 Daniel Bristot
 Joel Fernandes
 Vineeth Pillai
 Youssef Esmat

But it's open to anyone that wants to attend. I should send out more
invites to others that participate in the scheduler work. I sent an invite
to Peter, but he's never accepted.

And sometimes we get a few others. It's mostly just to discuss latest
trends of the scheduler.

-- Steve
