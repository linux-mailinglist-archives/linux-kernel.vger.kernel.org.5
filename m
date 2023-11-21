Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 033F67F280C
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 09:52:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229620AbjKUIwU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 03:52:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjKUIwS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 03:52:18 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11F9EE7
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 00:52:15 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D01FC433C7;
        Tue, 21 Nov 2023 08:52:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700556734;
        bh=R6zskyT0ImGwBcfH987qpr99gkxs/wApxrL5UDiXm7I=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=b7HcNKI4zXYyd9J9DThMtaWzTEwZFpeBeaouvedi7fuVq1aB7oxRZp8lKz6Z0cbvG
         n2vKRhlwA5f/Vdv7fsaS36pfgqOGMYJuxh1FSza7CdQwlPaQqBlHi3rzk54GmWRQlI
         ixLSP7N3vWQgNgX106p1t1gmYXNTOlPABR6i3rmUwVGZ4bPF7x92hGASRrnxraZkCG
         qTDdQ3fXSk+vsr2pQO7iCFM7Vpoqjwvg5QGkbDwDUyV3iuOMaY5FU81ndDoJSm3wJ7
         d4zsoRe334wVmlKprSLCP43W3LAjIenlplZEcx/cC+HmaHOeIjddq6IDcmr4pLQd5h
         LbxseE/vwDlig==
Date:   Tue, 21 Nov 2023 09:52:11 +0100 (CET)
From:   Jiri Kosina <jikos@kernel.org>
To:     Denis Benato <benato.denis96@gmail.com>
cc:     "Luke D. Jones" <luke@ljones.dev>, benjamin.tissoires@redhat.com,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] hid-asus: reset the backlight brightness level on
 resume
In-Reply-To: <b4356286-368a-49ec-b1f8-d7e5e4afdc25@gmail.com>
Message-ID: <nycvar.YFH.7.76.2311210951340.29220@cbobk.fhfr.pm>
References: <20231117011556.13067-1-luke@ljones.dev> <b4356286-368a-49ec-b1f8-d7e5e4afdc25@gmail.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 Nov 2023, Denis Benato wrote:

> > From: Denis Benato <benato.denis96@gmail.com>
> 
> I want to express my gratitude toward Luke for his guidance and his help 
> in submitting this fix.
> 
> I confirm those patches were sent in my behalf.

Luke, as you were in the supply chain of the patches, could you please 
provide Signed-off-by: tags so that I can add them into the chain?

Thanks,

-- 
Jiri Kosina
SUSE Labs

