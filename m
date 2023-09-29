Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 939457B3C7A
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Sep 2023 00:00:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233585AbjI2WAs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 18:00:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232834AbjI2WAq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 18:00:46 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83B70B7
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 15:00:44 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3B69C433C9;
        Fri, 29 Sep 2023 22:00:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696024843;
        bh=89jTrq1DyohzStlU5zc3Tha8Xsv29TxLnDk3KQTTdzE=;
        h=Subject:From:To:Date:From;
        b=MM/syiKFglXQ2lEg2hwnIyLOvfZzpDjt2OwuGkl2+VUgjORKteY3mcRFPB8Jsd10V
         mMXHWo30aPjHxRI2nW6UCqH3p/oPymhziDnygYUjUBQPzEAcWFcPVFacORiRlWPNkt
         3LLRLYiGTHvGn4edq36bHpWJnYumjkp0HSHMtLqvNTU63j2OUkAK0P1RfTl00GqMv5
         QwdOHvaZWOcJpFprSoO5EGH2005kvg5clIc2CKb5g6HXcnNtl3bXfa+UcW5Xv8brNn
         W9PAY7JfSSmM9Ij/+FEMYQfL8O4RMluwApUzIba5N7I8G0o+N095uYCUctAmksRroy
         zUlX3KUM8s2TQ==
Message-ID: <666b831988329de027e63def44296a7b5a34149e.camel@kernel.org>
Subject: [ANNOUNCE] 5.4.257-rt87
From:   Tom Zanussi <zanussi@kernel.org>
To:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Daniel Wagner <wagi@monom.org>,
        Clark Williams <williams@redhat.com>,
        "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>,
        Tom Zanussi <zanussi@kernel.org>
Date:   Fri, 29 Sep 2023 17:00:37 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
MIME-Version: 1.0
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello RT Folks!

I'm pleased to announce the 5.4.257-rt87 stable release.

This release is just an update to the new stable 5.4.257
version and no RT specific changes have been made.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v5.4-rt
  Head SHA1: 78f7ec6fa8bdf48ab8fcbccef05f9cb882c124ce

Or to build 5.4.257-rt87 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v5.x/linux-5.4.tar.xz

  https://www.kernel.org/pub/linux/kernel/v5.x/patch-5.4.257.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/5.4/patch-5.4.257-rt8=
7.patch.xz

Enjoy!

   Tom

