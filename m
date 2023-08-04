Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08059770A04
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 22:48:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229991AbjHDUsO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 16:48:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229618AbjHDUsL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 16:48:11 -0400
Received: from mail-4319.protonmail.ch (mail-4319.protonmail.ch [185.70.43.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 009264C38
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 13:48:06 -0700 (PDT)
Date:   Fri, 04 Aug 2023 20:47:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
        s=protonmail; t=1691182083; x=1691441283;
        bh=dVK5thJG/d4WivXGlKQOT3yBXYSFaIU8V67BLTyAtb8=;
        h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
         Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
        b=WrMiBN4JgBzYbnlldhzOUEst9xyxM54o6kIsL1GtXaGkqVm5cEocmJBXdDtKRn8Lg
         Qzk8ONS+yURsMPyghqTePuido4SQW5ifAs+lm5eYtZqKTXIjoJaIX3V9Z7S6VTX/nK
         3gDloL6sB0nIYCpymefriFIGgeqnxnml3lm5lKZ9qH6dMAxf/MjxPLW3ic/3tEcEdE
         qYIPTs40hsOfP9xltxgCg871XujGp+gERqh8CkKKvjp8ZwSUI0rW6TMqdCFcuo1lMe
         XnXPbrgmT908dfTcUE/FAfxThrjErBKp+2wHaR7fWkPsUgDeRIicXfWbg07lzKEBDu
         /ytbabGE0JqpQ==
To:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "asahi@lists.linux.dev" <asahi@lists.linux.dev>
From:   a20line <a20line@proton.me>
Cc:     "arnd@arndb.de" <arnd@arndb.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "marcan@marcan.st" <marcan@marcan.st>,
        "sven@svenpeter.dev" <sven@svenpeter.dev>,
        "alyssa@rosenzweig.io" <alyssa@rosenzweig.io>
Subject: Discrepancies in Asahi Linux patch submissions
Message-ID: <T3ZEuG8R3BUdqIoCdT3Yp_hQSvz4M0zTtZR3teIKQaaxI3VCxOm6QXDzq-Ub46rkpT-v688CZNmBwnjFP2x5LWhMeWUr-rjOdTKrL_L7k50=@proton.me>
Feedback-ID: 82752623:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

An investigation has uncovered that many Linux patches regarding the Linux =
on Apple Silicon project, otherwise known as "Asahi Linux", are being submi=
tted under false pretenses.

Specifically, the person that calls themselves "Asahi Lina" is actually Hec=
tor Marcan. There is no such person as "Asahi Lina", and Kernel policy spec=
ifically prohibits the submission of patches under fake names or anonymous =
aliases. The developer code of origin states that real names must be used a=
nd that "pseudonyms or anonymous contributions" are not allowed.

How do we know that Asahi Lina is Hector?

This screencap was taken from one of Asahi Lina's streams: https://files.ca=
tbox.moe/bcmnmr.png. You can clearly see that he breaks character for a mom=
ent when he tries to switch his home directory from his "Asahi" persona to =
his real world identity as Hector Marcan.

He has also done streams were he seamlessly transitions from his "Hector" i=
dentity to his "Asahi Lina" identity, like this one: https://www.youtube.co=
m/watch?v=3DeffHrj0qmwk (archived: https://ghostarchive.org/varchive/effHrj=
0qmwk).

Asahi Lina has also made statements such as: "If you want to support my wor=
k, you can donate to marcan=E2=80=99s Asahi Linux support fund on GitHub Sp=
onsors or Patreon, which helps me out too!"
This is only some of the evidence that corroborates to Hector Marcan being =
Asahi Lina.

Each piece of evidence, on their own, might not mean much. But put together=
 it puts a compelling argument that Asahi Lina *is* Hector Marcan. There ar=
e countless patches that have been submitted under these false pretenses, s=
uch as https://lore.kernel.org/asahi/5780e4c4-b0a0-382f-d659-9c4722a3582c@a=
sahilina.net/ . To ensure fairness in Kernel submission processes, Hector s=
hould retire the use of the "Asahi Lina" character when it regards to the s=
ubmission of patches to the Linux Kernel.
