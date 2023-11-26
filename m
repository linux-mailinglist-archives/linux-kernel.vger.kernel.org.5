Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C4427F9799
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 03:45:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231441AbjK0Cpc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Nov 2023 21:45:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229871AbjK0Cpb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Nov 2023 21:45:31 -0500
X-Greylist: delayed 11309 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 26 Nov 2023 18:45:37 PST
Received: from nc-ph-4035.digitalsserver.com (nc-ph-4035.digitalsserver.com [66.29.156.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A3CAE3
        for <linux-kernel@vger.kernel.org>; Sun, 26 Nov 2023 18:45:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=russianrealestateflorida.com; s=default; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:Message-ID:Date:Subject:To:From:Reply-To:Sender:Cc:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=30YuB/L8ZWVcvKLqMZZ+n0wu2iU2jeIwI3gSjlUmNs8=; b=R0DuFPFgEGBquZGLLWraKjwyyR
        2ZE7CtkGyC49C8oPpsxh8mwGZusNg6HJapsNjGlArLjBnO01fJ/GGdlZlXYSGk/4HH74McsZ8OQYl
        yIkH0NmQVB+jbHTRcCl6XoPFgju6PEw0L5ht0yvdD40Dqd4QFuVs0XadzWy+oCXuZwFMRvQ+aA/vA
        WSprrPkIAcMLZlfOP1XDf8iZR3EfpK9cLqS10jj9vlvTkGithf310O4etAYuwB+f9euXPLzIa8Hye
        wezSsuWNQnPTAgF7NSTgjMBIn7sipvBqK9e2LsfQmXc+4853u9KTojE7d2omctebajLrBwNfp/Lno
        D8Ud6+wQ==;
Received: from [46.183.223.78] (port=62229 helo=corptia.com)
        by nc-ph-4035.digitalsserver.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.96.2)
        (envelope-from <jobs@corptia.com>)
        id 1r7MBg-00047P-1q
        for linux-kernel@vger.kernel.org;
        Sun, 26 Nov 2023 20:57:10 +0000
Reply-To: projects@adnoc-suppplier.com
From:   Abu Dhabi National Oil Company <jobs@corptia.com>
To:     linux-kernel@vger.kernel.org
Subject: VENDORS EOI
Date:   26 Nov 2023 22:57:03 +0200
Message-ID: <20231126225703.4BDDFEEBCF7A6046@corptia.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - nc-ph-4035.digitalsserver.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - corptia.com
X-Get-Message-Sender-Via: nc-ph-4035.digitalsserver.com: authenticated_id: help@russianrealestateflorida.com
X-Authenticated-Sender: nc-ph-4035.digitalsserver.com: help@russianrealestateflorida.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Spam-Status: Yes, score=5.4 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_BL,RCVD_IN_MSPIKE_L3,
        SPF_HELO_PASS,SPF_SOFTFAIL,SUBJ_ALL_CAPS,TO_NO_BRKTS_FROM_MSSP,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: *  0.0 RCVD_IN_DNSWL_BLOCKED RBL: ADMINISTRATOR NOTICE: The query to
        *      DNSWL was blocked.  See
        *      http://wiki.apache.org/spamassassin/DnsBlocklists#dnsbl-block
        *      for more information.
        *      [66.29.156.93 listed in list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.9 RCVD_IN_MSPIKE_L3 RBL: Low reputation (-3)
        *      [66.29.156.93 listed in bl.mailspike.net]
        *  0.5 SUBJ_ALL_CAPS Subject is all capitals
        *  0.7 SPF_SOFTFAIL SPF: sender does not match SPF record (softfail)
        * -0.0 SPF_HELO_PASS SPF: HELO matches SPF record
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  0.0 RCVD_IN_MSPIKE_BL Mailspike blocklisted
        *  2.5 TO_NO_BRKTS_FROM_MSSP Multiple header formatting problems
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings of the day,

We are inviting your esteemed company for vendor registration and=20
intending partners for Abu Dhabi National Oil Company (ADNOC)
2023/2024 projects.

These projects are open for all companies around the world, if=20
you have intention to participate in the process, please confirm=20
your interest by asking for Vendor Questionnaire and EOI.

We appreciate your interest in this invitation, and look forward=20
to your early response.

Kind Regards,
Mr. Mohamed Ghazi B.
Senior Project Manager
projects@adnoc-suppplier.com
