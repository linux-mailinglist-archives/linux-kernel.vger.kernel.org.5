Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 807DF7B8178
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 15:56:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242707AbjJDN4W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 09:56:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233375AbjJDN4V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 09:56:21 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9E00AB;
        Wed,  4 Oct 2023 06:56:14 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A124C433C7;
        Wed,  4 Oct 2023 13:56:13 +0000 (UTC)
Date:   Wed, 4 Oct 2023 09:57:20 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Hans Verkuil <hverkuil-cisco@xs4all.nl>
Cc:     Ross Zwisler <zwisler@kernel.org>, linux-kernel@vger.kernel.org,
        Ross Zwisler <zwisler@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        Daniel Almeida <daniel.almeida@collabora.com>
Subject: Re: [PATCH] visl: use canonical ftrace path
Message-ID: <20231004095720.5727254a@gandalf.local.home>
In-Reply-To: <c7e21ecf-9554-425d-a8c1-90f890de6bb4@xs4all.nl>
References: <20230829204600.3210276-2-zwisler@kernel.org>
        <20231003174129.11c79c18@gandalf.local.home>
        <c7e21ecf-9554-425d-a8c1-90f890de6bb4@xs4all.nl>
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

On Wed, 4 Oct 2023 08:33:12 +0200
Hans Verkuil <hverkuil-cisco@xs4all.nl> wrote:

> On 03/10/2023 23:41, Steven Rostedt wrote:
> > 
> > Could this go through the linux-media tree, or if you give it an Ack, I'll
> > take it through the tracing tree.  
> 
> I prefer to take this through the media subsystem. Ross, can you post this

Thanks!

> patch again, this time including linux-media@vger.kernel.org?

The original patch did have linux-media@vger.kernel.org Cc'd. Was it dropped?

-- Steve


> 
> The patch looks fine, so I'll pick it up.
> 
> Regards,
> 
> 	Hans
