Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B483754309
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 21:08:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236018AbjGNTHq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 15:07:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235360AbjGNTHo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 15:07:44 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F3E335A0;
        Fri, 14 Jul 2023 12:07:44 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:73::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id E65A6733;
        Fri, 14 Jul 2023 19:07:43 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net E65A6733
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1689361664; bh=rmDB6Qndm6Bpm0bb1CI04d4s1C2p8wZ8bmhEjQHFV8E=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=ivlFY29CvAjC7UrHbsX1266r/+urUGlZiM/khRNHbNt8TvpBz/R9oArK+DfEZ5/Zq
         O+GLNYqOjN4271ZtBLxBP9nF/00weTniHf30frQC4qTmkNNlOMTbWjQ3iIDar6aa3y
         mtQYnfpZ1EJ5YNRZFj+4S9JWBvfUGSKBJv8kuF96vrKPIFZ1DN3AEShCkMbL0H/a6s
         PgztSH1tGdWl2ni2oVY73vApkUAK7AzKhs5afuYkhn+X+KCplHQIeb3KQ9UYiz4/YZ
         7yB4wUWjrPjZgGJDo+7gN5LINv9kE1AtY84k1KSPNBcVT6MjNYRWUmbOEAddmOTTMY
         Kk83kSyWSMLkA==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Hu Haowen <src.res.211@gmail.com>, siyanteng@loongson.cn,
        bobwxc@email.cn, alexs@kernel.org, gregkh@linuxfoundation.org,
        nabijaczleweli@nabijaczleweli.xyz, carlos.bilbao@amd.com,
        me@lirui.org
Cc:     Hu Haowen <src.res.211@gmail.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] docs/zh_TW: rewrite index.rst
In-Reply-To: <20230708054052.45967-1-src.res.211@gmail.com>
References: <20230708054052.45967-1-src.res.211@gmail.com>
Date:   Fri, 14 Jul 2023 13:07:43 -0600
Message-ID: <87351q1fcw.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hu Haowen <src.res.211@gmail.com> writes:

> Update zh_TW's index.rst to the version of commit 0c7b4366f1ab ("docs:
> Rewrite the front page") with some reference from commit f4bf1cd4ac9c
> ("docs: move asm-annotations.rst into core-api") and commit eef24f7054a6
> ("docs/zh_CN: Rewrite the Chinese translation front page").
>
> Signed-off-by: Hu Haowen <src.res.211@gmail.com>
> ---
>  Documentation/translations/zh_TW/index.rst | 156 ++++++++-------------
>  1 file changed, 56 insertions(+), 100 deletions(-)

So your two patches conflict with each other.  I've sorted it out and
applied this, but it would be nicer if I didn't have to do that...

Thanks,

jon
