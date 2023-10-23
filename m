Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 944997D287A
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 04:26:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233127AbjJWC0O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Oct 2023 22:26:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232910AbjJWC0M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Oct 2023 22:26:12 -0400
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF1A819E;
        Sun, 22 Oct 2023 19:26:10 -0700 (PDT)
Received: from localhost (mdns.lwn.net [45.79.72.68])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 8FAE8490;
        Mon, 23 Oct 2023 02:26:10 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 8FAE8490
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1698027970; bh=FYLKw2297A0PIUDq5riMXejanWx7UptvS+3NVqjBwt0=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=ChLVm56RlrwN3u+sTucU4WJaMD2qkHMQhSJF06+30g24aP5nGzzNDYU0cdAFXXgiC
         fjHxGTmPdmlVkhimp4AyTVViXI0QovHrc4zKMTLd1Za2ptzbH1j98UirDkt3DvVx1Q
         hg2hQ2TemVcXXQLmrmx5m/pzoEY+fny6Ke8g84ineb/RrxTugqTKLTWsyi8/rZICI4
         EjcoMuURPQpK1hVjspHP53OoJtVreFJWkKqoBBJ5GWPi4Rfws9sC3TSleMmpLLrggA
         E4m2eBZaA5qO+aEjtkY/ZcqWgrGlWCvs6fKewWL3W4E9pxh4Q5V0eB42SeUBQ4POJD
         jRY5eKbfxkh9Q==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Hu Haowen <2023002089@link.tyut.edu.cn>
Cc:     Hu Haowen <2023002089@link.tyut.edu.cn>, src.res.211@gmail.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] docs/zh_TW: replace my email address
In-Reply-To: <87lebukrs2.fsf@meer.lwn.net>
References: <20231012130008.102174-1-2023002089@link.tyut.edu.cn>
 <87lebukrs2.fsf@meer.lwn.net>
Date:   Sun, 22 Oct 2023 20:26:09 -0600
Message-ID: <87cyx6krb2.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jonathan Corbet <corbet@lwn.net> writes:

> Hu Haowen <2023002089@link.tyut.edu.cn> writes:
>
>> The Gmail address will not be used often from now on, and replace it
>> with the email which is more frequently accessed by myself.
>>
>> Signed-off-by: Hu Haowen <2023002089@link.tyut.edu.cn>
>
> Applied.

Actually, no:

Documentation/translations/zh_TW/dev-tools/sparse.rst:10: WARNING: Title underline too short.

Traditional Chinese maintainer: Hu Haowen <2023002089@link.tyut.edu.cn>
---------------------------------------------------------------------

Unapplied.

Please do not send me anything for a while, at least until you have
worked out a process that does not make me find the problems you are
adding with each patch.

jon
