Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 015A6790A75
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Sep 2023 03:23:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235303AbjICBHQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Sep 2023 21:07:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231735AbjICBHP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Sep 2023 21:07:15 -0400
Received: from mail-4027.protonmail.ch (mail-4027.protonmail.ch [185.70.40.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25B2ECDD
        for <linux-kernel@vger.kernel.org>; Sat,  2 Sep 2023 18:07:11 -0700 (PDT)
Date:   Sun, 03 Sep 2023 01:07:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
        s=protonmail; t=1693703228; x=1693962428;
        bh=/Fv0PbLotrEW9Fq3nO912Av3FftPaq7rErQ6eFrva+0=;
        h=Date:To:From:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=RJMcKbExgO9HxkY/dYAR53L3jhNq2zyqCVSeQd2L/y/AkdUqoWzhmoWOffnrWwiwa
         4dc4gX0jEEWIHoPoyq+zVJ9rv5MznNVw9xfkM9E9E/EWN6BjHAdcKW0ztL7W0hgUfw
         cKjmx7XV6wBbC+JV3A5YL3H1fgsbOLDhuoHq1yOHM4kTvylyptZ9OZtBLgFwykHftQ
         wlAuP7ptqQZP7Dsu9AyoqzGQfMGcC7u5sjdwvzVI5UQochuKT28gQl0WDbRolZQV/S
         bIHwo95IsoATtISo9NbzAJGrVEnWUwBwuy+eEMHfXuS7WUsYzWfmED376gtbMpYBpB
         GZj8lIg+qLKpg==
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From:   youngbludproductions <youngbludproductions@proton.me>
Subject: Re: [PATCH] Update: Fixing SSH Hardware Key Issue
Message-ID: <tB722WaV9r9HqtIuctwx4NML64gv3Q0eiOiC9q9BxdxIZvc4naV6StrrpzQ3GQOyUeG0aRQYAidrlwOdA9DadrTLUbQgB2dhpzUeCu8SKsA=@proton.me>
In-Reply-To: <tAhUQSc5uwwjQtY_kdRUe79bpsl4gT2YVxWd3n59lBqUkyhPfEh_rj5lGKxWhxCNYzKJTziLWTYS75zRm8hXJ9AvF46WCMePw-1OybIrxsE=@proton.me>
References: <TQT4YufaV3YuStoFkD5gAcplDIsO76FYEqGQqYzLxrWzgNJ2FwqI__DjgyBZlPSOV6BVJXE54Wf8zroK728hlDXV2Mn5wt9kw2iovRBGPuI=@proton.me> <tAhUQSc5uwwjQtY_kdRUe79bpsl4gT2YVxWd3n59lBqUkyhPfEh_rj5lGKxWhxCNYzKJTziLWTYS75zRm8hXJ9AvF46WCMePw-1OybIrxsE=@proton.me>
Feedback-ID: 85224644:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Just wanted to check in on my patch. Any issues on your end?

Thanks,
Clyde
