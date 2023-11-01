Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5FFC7DE5EE
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 19:17:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344676AbjKASRO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 14:17:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233335AbjKASRM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 14:17:12 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8526DA
        for <linux-kernel@vger.kernel.org>; Wed,  1 Nov 2023 11:17:09 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83491C433C8;
        Wed,  1 Nov 2023 18:17:08 +0000 (UTC)
Date:   Wed, 1 Nov 2023 14:17:05 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     gregkh@linuxfoundation.org, keescook@chromium.org,
        willy@infradead.org, senozhatsky@chromium.org, list@mail.com,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: Re: [PATCH 0/2] seq_buf: Export seq_buf_putc() &nd seq_buf_puts()
Message-ID: <20231101141705.4208d441@gandalf.local.home>
In-Reply-To: <cover.1698861216.git.christophe.jaillet@wanadoo.fr>
References: <cover.1698861216.git.christophe.jaillet@wanadoo.fr>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed,  1 Nov 2023 18:59:04 +0100
Christophe JAILLET <christophe.jaillet@wanadoo.fr> wrote:

> seq_buf_putc() has a potential real use-case (link in the patch), but 
> seq_buf_puts() has currently no forseen use-case, so I have split it in 2
> patches if only the 1st one is accepted.
> 
> Christophe JAILLET (2):
>   seq_buf: Export seq_buf_putc()
>   seq_buf: Export seq_buf_puts()
> 
>  lib/seq_buf.c | 2 ++
>  1 file changed, 2 insertions(+)
> 

I can pull these in as I'm getting ready for my pull request to Linus soon
(and just kicked off my testing).

Or do you need them as part of the patch you mentioned? When does that need
to go in? Can it wait till it hits Linus's tree?

-- Steve
