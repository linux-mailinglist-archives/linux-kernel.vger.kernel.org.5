Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E8C275D605
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 22:56:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230360AbjGUU4C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 16:56:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229642AbjGUU4B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 16:56:01 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0C2A30EA;
        Fri, 21 Jul 2023 13:56:00 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:73::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 5F44E7DB;
        Fri, 21 Jul 2023 20:56:00 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 5F44E7DB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1689972960; bh=/pNOgmbpRibh+2IvibxYnMwYoW2aecJ/X1jzARhPnjQ=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=eS6gjpDldz+QueWWIscrKJwIaEQk8hytszNbSmKJHYFg+RNWdN9FNP3U5wj/63NfP
         yxPk/pE2n26cVEnJD20HQQebIeJK8rz2+GQDMez8r0BztFF1OzwI0TJKkNO2RDH60I
         0HtvDYM8soYJKhmrHxyEabWV8a3U8RMAPVLaafJdabomeOMYs8r4lhYReRpNDKjV4Z
         RV8t5vzeP/IqWvvm3iADQXr6/crlwsnFeU5GujtfkRpRtXmti6vALFxInrSNdLexeg
         WOW9cHmGUaQnwyCjztPxLwQj+naG9hkBXBTq6/P4cdH0VyBsXj2MZdlNlDcr9LiCLE
         ixwPOzbyzEuzg==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Costa Shulyupin <costa.shul@redhat.com>, linux-doc@vger.kernel.org
Cc:     Costa Shulyupin <costa.shul@redhat.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/3] docs: consolidate networking interfaces
In-Reply-To: <20230715165736.74816-1-costa.shul@redhat.com>
References: <20230715165736.74816-1-costa.shul@redhat.com>
Date:   Fri, 21 Jul 2023 14:55:59 -0600
Message-ID: <878rb9c7c0.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Costa Shulyupin <costa.shul@redhat.com> writes:

> to make the page more organized as requested
>
> Signed-off-by: Costa Shulyupin <costa.shul@redhat.com>
> ---
>  Documentation/subsystem-apis.rst | 17 ++++++++++++-----
>  1 file changed, 12 insertions(+), 5 deletions(-)

Applied, thanks.

jon
