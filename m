Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C53AE793A0C
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 12:38:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238059AbjIFKit (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 06:38:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229986AbjIFKir (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 06:38:47 -0400
Received: from a3.inai.de (a3.inai.de [IPv6:2a01:4f8:10b:45d8::f5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D6AECE2
        for <linux-kernel@vger.kernel.org>; Wed,  6 Sep 2023 03:38:43 -0700 (PDT)
Received: by a3.inai.de (Postfix, from userid 25121)
        id DD381580DA986; Wed,  6 Sep 2023 12:38:30 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by a3.inai.de (Postfix) with ESMTP id DA693624A798C;
        Wed,  6 Sep 2023 12:38:30 +0200 (CEST)
Date:   Wed, 6 Sep 2023 12:38:30 +0200 (CEST)
From:   Jan Engelhardt <jengelh@inai.de>
To:     o-takashi@sakamocchi.jp
cc:     linux1394-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] emsmdb: consolidate repeated call logic around get_rpc_info()
 [2/3]
In-Reply-To: <20230906083244.25768-1-jengelh@inai.de>
Message-ID: <s6267n5s-159q-530p-sqnn-01qn9r8n88o8@vanv.qr>
References: <20230906083244.25768-1-jengelh@inai.de>
User-Agent: Alpine 2.26 (LSU 649 2022-06-02)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 2023-09-06 10:32, Jan Engelhardt wrote:
> exch/emsmdb/oxcfxics.cpp | 51 ++++++++++++++--------------------------

Ignore this. Someday, I'll figure out how to defuse the destructive 
potency that libreadline's Ctrl-R feature can have ... :-/
