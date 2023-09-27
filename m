Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 394ED7B04F4
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 15:07:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231855AbjI0NHw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 09:07:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231826AbjI0NHt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 09:07:49 -0400
Received: from correo1.cdmx.gob.mx (mtax.cdmx.gob.mx [189.240.235.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65E80180
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 06:07:47 -0700 (PDT)
Received: from cdmx.gob.mx ([10.250.108.150])
        by correo1.cdmx.gob.mx  with ESMTP id 38RD6kE7001779-38RD6kE9001779
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 27 Sep 2023 07:06:46 -0600
Received: from cdmx.gob.mx (localhost [127.0.0.1])
        by cdmx.gob.mx (Postfix) with ESMTPS id 4A349245648;
        Wed, 27 Sep 2023 06:26:31 -0500 (CDT)
Received: from localhost (localhost [127.0.0.1])
        by cdmx.gob.mx (Postfix) with ESMTP id 1DBA724751C;
        Wed, 27 Sep 2023 06:26:31 -0500 (CDT)
DKIM-Filter: OpenDKIM Filter v2.9.2 cdmx.gob.mx 1DBA724751C
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; d=cdmx.gob.mx; s=DKIM1; c=relaxed/relaxed;
 h=content-type:mime-version:subject:to:from:date:reply-to:message-id;
 bh=rbCGcTJSOVdxWQVJZtY1DjWa3k6lXdwZwrNXiXGvY0o=;
 b=IjpV2fBjFjs7H7NnHV/L7pZ8J5X02CHnvMRA2u7aeqMSq4kB/rDaIFJHfsJkS6rA0pewktCgybE3
        lpqstH081Uvhs6fBjH2Shx4ykqJpq65UUX4iAls04qQUb04DyNT89ENQp049JnJctK0jKylsCozh
        IAD6Ar0D+3aDTdcBIXz+IpBvXs0aczLDLRxuQndaGBBjxgyo3z+UMrvWsN807CWmB4gM16ySKsHp
        QP+TSTtD4UzaCK9zXz6ODW4hLYE3BwDA7seOGveGIuNpEclTmEmbg0nNYDX+DtSDWtEw2HHiefDe
        VjcMBN78LYJR/w15z8C9O6VEBKtDbdOskrYNQw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cdmx.gob.mx;
        s=2020J4N146MXCTY; t=1695813991;
        bh=rbCGcTJSOVdxWQVJZtY1DjWa3k6lXdwZwrNXiXGvY0o=;
        h=Content-Type:MIME-Version:Content-Transfer-Encoding:Subject:To:
         From:Date:Reply-To:Message-Id;
        b=SxdvC8wlwKWLkRMjM/ZQih0eNqXRM2kU7H42dEwsdMmm71aPBnUgfEpmr3bOCJPb2
         zo9CHj0zkceN0uFgXD3ZDht2yaS0yB3GUzsZwMl2sZiit4IVxvWDiF/sUHH0I6q+W9
         b36FQAVpZt9d779vRpvOoK8VRassGgZGEkUBlNwo=
X-Virus-Scanned: amavisd-new at cdmx.gob.mx
Received: from cdmx.gob.mx ([127.0.0.1])
        by localhost (cdmx.gob.mx [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id OKEnLFTnUbij; Wed, 27 Sep 2023 06:26:31 -0500 (CDT)
Received: from [193.232.179.65] (unknown [154.6.13.140])
        by cdmx.gob.mx (Postfix) with ESMTPSA id EE238245648;
        Wed, 27 Sep 2023 06:26:25 -0500 (CDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Description: Mail message body
Subject: SPENDE
To:     Recipients <oportillor@cdmx.gob.mx>
From:   "Leonard Valentinovich" <oportillor@cdmx.gob.mx>
Date:   Wed, 27 Sep 2023 15:26:57 +0300
Reply-To: sirleonard@englandmail.com
Message-Id: <20230927112625.EE238245648@cdmx.gob.mx>
X-Spam-Status: Yes, score=6.0 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_REPLYTO,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Report: *  3.3 RCVD_IN_SBL_CSS RBL: Received via a relay in Spamhaus SBL-CSS
        *      [154.6.13.140 listed in zen.spamhaus.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5117]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  2.1 FREEMAIL_FORGED_REPLYTO Freemail in Reply-To, but not From
X-Spam-Level: ******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Guten Tag. Mein Name ist Leonard Valentinovich
Sie gehoren zu den ausgewahlten Personen, die eine Spende von meinem Untern=
ehmen (Access Industries) erhalten. Wenn Sie an einer finanziellen Spende i=
nteressiert sind, schreiben Sie mir bitte fur weitere Einzelheiten zuruck.
