Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 434DD7C8E7D
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 22:46:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231886AbjJMUqm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 16:46:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231726AbjJMUqk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 16:46:40 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10AC4B7
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 13:46:39 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1697229997;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0wu8RX4GHCj8HiatXq1jJq5lLXmIkM9iT1J3XjZWdio=;
        b=ldhtbyyu3VSzHgPRc95/schVcbCgcpxqv7SaL2OqCZ0Oosws5jgCl7cLqwamxuXRw95cdq
        y2DtySRB48RAzkSd83iYEf6RN/nc5p7yTVrngljxflikyAaSXmY0FQ6+Lr1TRjnv/3Aa70
        py2uAGpSRS/VF7Fd9o06qp8urWRJm5u007d+NSlbdU4+gdZhgJykc+btzvB+FicxT8NSwM
        7keBMZRNQtaXFcvFb6yighnuMBcqmKBK84LkoNdVfKuNZ4hKiSMaLEvUvvig2xhVU9jDHT
        sCnHf04CLLRklZ6KD/lO59bAbuWZFYskCy8hO4GW4zr5rpG1+Ab0oM4DO05d0g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1697229997;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0wu8RX4GHCj8HiatXq1jJq5lLXmIkM9iT1J3XjZWdio=;
        b=48Jb+t95WfCSxP3mAxBlHqZSsJgRmLJVeAZjw2yFlSZZ2vgjwV0lDTw+4QJDvuSFR5uwUY
        4ZTOh5XC16z39XBw==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH printk v2 0/4] fix console flushing on panic
In-Reply-To: <20231013204340.1112036-1-john.ogness@linutronix.de>
References: <20231013204340.1112036-1-john.ogness@linutronix.de>
Date:   Fri, 13 Oct 2023 22:52:32 +0206
Message-ID: <878r869ro7.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INVALID_DATE_TZ_ABSURD,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Oops. This series is not a v2. It is v1.

John
