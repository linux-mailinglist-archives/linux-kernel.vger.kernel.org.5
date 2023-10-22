Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F26F17D229A
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Oct 2023 12:25:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231953AbjJVKZM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Oct 2023 06:25:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231819AbjJVKZG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Oct 2023 06:25:06 -0400
Received: from mxout70.expurgate.net (mxout70.expurgate.net [91.198.224.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE331D67
        for <linux-kernel@vger.kernel.org>; Sun, 22 Oct 2023 03:25:03 -0700 (PDT)
Received: from [127.0.0.1] (helo=localhost)
        by relay.expurgate.net with smtp (Exim 4.92)
        (envelope-from <prvs=9673dbd9fc=fe@dev.tdt.de>)
        id 1quVdh-009fCq-Ok; Sun, 22 Oct 2023 12:24:57 +0200
Received: from [195.243.126.94] (helo=securemail.tdt.de)
        by relay.expurgate.net with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <fe@dev.tdt.de>)
        id 1quVdg-005dUN-Qg; Sun, 22 Oct 2023 12:24:56 +0200
Received: from securemail.tdt.de (localhost [127.0.0.1])
        by securemail.tdt.de (Postfix) with ESMTP id 6DDD0240049;
        Sun, 22 Oct 2023 12:24:56 +0200 (CEST)
Received: from mail.dev.tdt.de (unknown [10.2.4.42])
        by securemail.tdt.de (Postfix) with ESMTP id C0246240040;
        Sun, 22 Oct 2023 12:24:55 +0200 (CEST)
Received: from mail.dev.tdt.de (localhost [IPv6:::1])
        by mail.dev.tdt.de (Postfix) with ESMTP id 7873A213BE;
        Sun, 22 Oct 2023 12:24:55 +0200 (CEST)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Sun, 22 Oct 2023 12:24:55 +0200
From:   Florian Eckert <fe@dev.tdt.de>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Eckert.Florian@googlemail.com, jirislaby@kernel.org, pavel@ucw.cz,
        lee@kernel.org, kabel@kernel.org, u.kleine-koenig@pengutronix.de,
        ansuelsmth@gmail.com, m.brock@vanmierlo.com,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-leds@vger.kernel.org
Subject: Re: [PATCH v4 1/3] tty: whitespaces in descriptions corrected by
 replacing tabs with spaces
In-Reply-To: <2023102110-starlight-wispy-1f28@gregkh>
References: <20231019112809.881730-1-fe@dev.tdt.de>
 <20231019112809.881730-2-fe@dev.tdt.de>
 <2023102110-starlight-wispy-1f28@gregkh>
Message-ID: <dce966de5bec159dae67d958653aaa42@dev.tdt.de>
X-Sender: fe@dev.tdt.de
User-Agent: Roundcube Webmail/1.3.17
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-purgate-ID: 151534::1697970297-DEFDB1F7-2BE9C24B/0/0
X-purgate-type: clean
X-purgate: clean
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-10-21 18:28, Greg KH wrote:
> On Thu, Oct 19, 2023 at 01:28:07PM +0200, Florian Eckert wrote:
>> Tabs were used in the function description, to make this look more
>> uniform, the tabs were replaced by spaces where necessary.
>> 
>> While we're at it, I also replaced the 'ndashes' with simple dashes, 
>> since
>> only those are supported by sphinx.
>> 
>> Reviewed-by: Jiri Slaby <jirislaby@kernel.org>
>> Signed-off-by: Florian Eckert <fe@dev.tdt.de>
>> ---
>>  drivers/tty/tty_io.c | 102 
>> +++++++++++++++++++++----------------------
>>  1 file changed, 51 insertions(+), 51 deletions(-)
> 
> This didn't apply cleanly as portions of this patch were already in my
> tree, what did tree did you make it against?

I have already seen that I should add a base commit next time.
So I made it against the master from last week.

However, I was not sure which tree to use as I am changing
something in the tty and led subsystem-

> Anyway, I've fixed it up and taken it now.

Thank you for adopting my change and correcting my commit so that
it can be applied cleanly.

I will not add this patch in the next series, as it is already in the
tty-testing branch [1] from you?

---
Florian

Links:
[1] 
https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git/commit/?h=tty-testing&id=838eb763c3e939a8de8d4c55a17ddcce737685c1
