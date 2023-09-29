Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 639517B33FF
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 15:48:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233393AbjI2Nsq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 09:48:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233217AbjI2Nso (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 09:48:44 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A5B2DB
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 06:48:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=vBdvnasbJFYL49Za+XqXsG/Ee5Z6zginuImmIxkBZ+g=; b=d87HRL+57q8971gv8nSnQb8N6Q
        BqIz/yoi1qUktp3neRF23Pw1d43o+nDV9qRt3V4aChwT3gLem9cioDZcrKQB6I7Dx+SaRMKZ5XeZG
        5GyrS0y7gnH4TE1XlGKDTIem+6sYJx0w/4FubB/mluoz+K3HUzf+N6WeKdlIxGNMx2ODxZKiTzNVb
        Q+B9fKQaNZfHdSwcuyiHmpHDW57GBVFmEt440GMKxBKXR1Xum2xTCilfY6qHdePjEGTiNjmGuwrwR
        jfk+hHWZLjJAZ1RZo1ULfrvUhpt7EKtQTi8zsaiUnsc8G4EGodylPKHXsNtB+IHUpO/YE1Iv8opdY
        0GKzNJdQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qmDrB-00958z-IK; Fri, 29 Sep 2023 13:48:37 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id 3E36C30030F; Fri, 29 Sep 2023 15:48:37 +0200 (CEST)
Date:   Fri, 29 Sep 2023 15:48:37 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Masanari Iida <standby24x7@gmail.com>
Cc:     linux-kernel@vger.kernel.org, mingo@redhat.com, vschneid@redhat.com
Subject: Re: [PATCH] sched/topology: Fix a spelling typo in message.
Message-ID: <20230929134837.GG6282@noisy.programming.kicks-ass.net>
References: <20230929133345.259360-1-standby24x7@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230929133345.259360-1-standby24x7@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 29, 2023 at 10:33:45PM +0900, Masanari Iida wrote:
> This patch fixes a spelling typo in toloplogy.c

Please, google before sending patches, this is not a typo. Your spell
checker is broken for not including humour.
