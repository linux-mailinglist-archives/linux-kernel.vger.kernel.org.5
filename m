Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADC107E32A5
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 02:40:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233009AbjKGBkb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 20:40:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230208AbjKGBk3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 20:40:29 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7959E10D
        for <linux-kernel@vger.kernel.org>; Mon,  6 Nov 2023 17:40:27 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10CA3C433C8;
        Tue,  7 Nov 2023 01:40:24 +0000 (UTC)
Date:   Mon, 6 Nov 2023 20:40:26 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     jim.cromie@gmail.com
Cc:     =?UTF-8?B?xYF1a2Fzeg==?= Bartosik <lb@semihalf.com>,
        Jason Baron <jbaron@akamai.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Guenter Roeck <groeck@google.com>,
        Yaniv Tzoreff <yanivt@google.com>,
        Benson Leung <bleung@google.com>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        Pekka Paalanen <ppaalanen@gmail.com>,
        Sean Paul <seanpaul@chromium.org>,
        Daniel Vetter <daniel@ffwll.ch>, linux-kernel@vger.kernel.org,
        upstream@semihalf.com, pmladek@suse.com,
        sergey.senozhatsky@gmail.com, john.ogness@linutronix.de,
        Simon Ser <contact@emersion.fr>
Subject: Re: [PATCH v1 05/12] tracefs: add TP_printk_no_nl - RFC
Message-ID: <20231106204026.78940dfe@gandalf.local.home>
In-Reply-To: <CAJfuBxwKXRd1vVtpxCOh7_jWrO3CQU0H+3gOvNkYBt-m3V75pw@mail.gmail.com>
References: <20231103131011.1316396-1-lb@semihalf.com>
        <20231103131011.1316396-6-lb@semihalf.com>
        <CAJfuBxwKXRd1vVtpxCOh7_jWrO3CQU0H+3gOvNkYBt-m3V75pw@mail.gmail.com>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 3 Nov 2023 21:40:13 -0600
jim.cromie@gmail.com wrote:

> Steve,
> IIRC you considered adding \n where needed.
> is there anything gained (conceivably) by not just adding the trailing
> \n when "needed" ?
> statistically, macros could get us to 99.99+ "compliance"
> IIRC - the "needed" seems correct.
> 

I replied to the next patch suggesting to do this on the read side.

-- Steve
