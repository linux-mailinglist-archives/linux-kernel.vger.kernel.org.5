Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 602737D1985
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Oct 2023 01:16:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229614AbjJTXQF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 19:16:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjJTXQE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 19:16:04 -0400
Received: from mail-0301.mail-europe.com (mail-0301.mail-europe.com [188.165.51.139])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D9ACD46
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 16:15:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
        s=protonmail; t=1697843753; x=1698102953;
        bh=4kP1SrlImVQvijZfLa/DYuaMhF1rtRMbLjnfGPAkB7g=;
        h=Date:To:From:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=Kcqg50Z4LpRs0fMAXyIciHgXBn2cBZQhTv4JLegDe/032EDY607+x3I7StWo/UZqt
         cX0P/JWzs46Rh2841EsHx41jYQ7mHMMYNXIxuUv6Ikzu72ctwk5INdtW4LfGo2s8Tc
         gjGIRqt76Wdy+7wNLTvkDalqYlbkwLkkX8xvcR7ASpUvCK+odJ+dAqTWfoJmAYJjzz
         fEONJe2AJFhFJ4GWrNvqz0v6I6koly5kJckB1QE4mxVOlfET2pmUuwOG7v8/hPCdrq
         6uwVu+k0lmhbrjziUKdMkMqpNQOy+EHwA+oNJ8W5o+LHYwglzNBA/acHo1+S6GnHk5
         Aij0L6A3CY/RQ==
Date:   Fri, 20 Oct 2023 23:15:45 +0000
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From:   youngbludproductions <youngbludproductions@proton.me>
Subject: Re: [PATCH] Update: Fixing SSH Hardware Key Issue
Message-ID: <w_eCxU02z0Fy-VeYdtdKYq73wdUGL5VRWXz3dgjndfTYOrYQiSAGJglyNUS8Vv6kEFdFiaAUPJHEbg-MCogBelKpLxg7edTEfWMXudCAr-A=@proton.me>
In-Reply-To: <tB722WaV9r9HqtIuctwx4NML64gv3Q0eiOiC9q9BxdxIZvc4naV6StrrpzQ3GQOyUeG0aRQYAidrlwOdA9DadrTLUbQgB2dhpzUeCu8SKsA=@proton.me>
References: <TQT4YufaV3YuStoFkD5gAcplDIsO76FYEqGQqYzLxrWzgNJ2FwqI__DjgyBZlPSOV6BVJXE54Wf8zroK728hlDXV2Mn5wt9kw2iovRBGPuI=@proton.me> <tAhUQSc5uwwjQtY_kdRUe79bpsl4gT2YVxWd3n59lBqUkyhPfEh_rj5lGKxWhxCNYzKJTziLWTYS75zRm8hXJ9AvF46WCMePw-1OybIrxsE=@proton.me> <tB722WaV9r9HqtIuctwx4NML64gv3Q0eiOiC9q9BxdxIZvc4naV6StrrpzQ3GQOyUeG0aRQYAidrlwOdA9DadrTLUbQgB2dhpzUeCu8SKsA=@proton.me>
Feedback-ID: 85224644:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello?
