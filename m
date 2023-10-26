Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 061C87D83E5
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 15:52:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345109AbjJZNwm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 09:52:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234789AbjJZNwk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 09:52:40 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DF87CC
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 06:52:38 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA9D6C433C7;
        Thu, 26 Oct 2023 13:52:36 +0000 (UTC)
Date:   Thu, 26 Oct 2023 09:52:35 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     Christoph Hellwig <hch@lst.de>, Kees Cook <keescook@chromium.org>,
        Justin Stitt <justinstitt@google.com>,
        Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org, ksummit@lists.linux.dev
Subject: Re: the nul-terminated string helper desk chair rearrangement
Message-ID: <20231026095235.760f5546@gandalf.local.home>
In-Reply-To: <710149630eb010b18b69e161d02502bc3b648173.camel@HansenPartnership.com>
References: <20231018-strncpy-drivers-nvme-host-fabrics-c-v1-1-b6677df40a35@google.com>
        <20231019054642.GF14346@lst.de>
        <202310182248.9E197FFD5@keescook>
        <20231020044645.GC11984@lst.de>
        <CAFhGd8o8FaD-3rkBAhEXhc8XqpUk_cLqNwyfpndVuSxDOei_gA@mail.gmail.com>
        <202310201127.DA7EDAFE4D@keescook>
        <20231026100148.GA26941@lst.de>
        <710149630eb010b18b69e161d02502bc3b648173.camel@HansenPartnership.com>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 26 Oct 2023 07:39:44 -0400
James Bottomley <James.Bottomley@HansenPartnership.com> wrote:

> While it's nice in theory to have everything documented, it's not much
> use if no one can actually find the information ...

Does kerneldoc provide an automated index? That is, if we had a single file
that had every function in the kernel that is documented, with the path to
the file that documents it, it would make finding documentation much
simpler.

Maybe it already does? Which would mean we need a way to find the index too!

-- Steve
