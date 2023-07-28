Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 562667676F3
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 22:24:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232050AbjG1UYY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 16:24:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229620AbjG1UYX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 16:24:23 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B3FF421D
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 13:24:22 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id 4fb4d7f45d1cf-522ab301692so612125a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 13:24:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690575860; x=1691180660;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=SyWx051AYSsya+pzm/2CESWC0aQN46Y6mRWxZ4kl/fY=;
        b=egf2Rz95PyDNX8IizAW5XrdqSjJf6qdj38CzmhwqczML/OIYIUEuzt9pfAc90nEwLn
         jtrv37frD//VlJOKN/DiRV7n3B+e0UzFXmPcUP1GLQcTaL3zzszw5xdf3lTmApyk7snC
         9Pl+9nqxnXuQJAozoq2qAzwf1Zh5AmyeKiNlBXUja2713h5BERQB84hq/L9qu0ZwqLaN
         cEzzD44FyZg5mBDjNzRXbx71ke7ANxmL3IpjKFsEKVkvjEaibWhjubR+cKUmPajIFslc
         y0arK5e8DhN0ZvHgPue4HrLhR8TtF0TiQxDuxWRox/xqamiiIUR0nDyh8Wj7nIAB0JnC
         NKAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690575860; x=1691180660;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SyWx051AYSsya+pzm/2CESWC0aQN46Y6mRWxZ4kl/fY=;
        b=LjOgDnK/B2AsQ9RggSm+xcD1JDGPHsQK82FaJjZKTIZvmLQVmeX7DPoQsXrPt/kzuG
         7zCwSQ1/qSHrkxwZyA4btfcwzlHlXu9DV5lPJAYOCdpdh9zr0oZwxXhUu7HfOvQSDHyu
         vtOo/a7UGVbHV8BtlXcR3l2E9BAwc8wsxim1hvA7mdsscpGWa23dzkc9qV9z/qsRj9q9
         BeYl+nj/JHmmTGzERrXlI33Z+GkYo4UxKj9cOgoJZnMgUnmMNvJI07W0OceA08psi9AH
         +GQXwV+Ur2W7nmWrlPooyX7l21bMniJoP38Fyr0QtbsKV0J888M+GQ0OVNvMpRhHCBgn
         dniQ==
X-Gm-Message-State: ABy/qLa7Rg6cHZJf4BoRzNX2+6I1DsPlIpPRMdtxGR00bNsWs70LUnuP
        qtFZ1vsRJqFaBmmu9cEALzfeCQbQAiv7QN0/EB1CEJuO+adHVw==
X-Google-Smtp-Source: APBJJlEQwAAJE7THVOfVT1AKUCR/Luci/f2ahGxKh3rLvwitZerOsACiJW4U0DagAxUgQaNb1ooPI7Jg1NHOERc4tVs=
X-Received: by 2002:aa7:d507:0:b0:522:3a28:feca with SMTP id
 y7-20020aa7d507000000b005223a28fecamr2821803edq.24.1690575860450; Fri, 28 Jul
 2023 13:24:20 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:aa7:c6d2:0:b0:51e:1856:95ca with HTTP; Fri, 28 Jul 2023
 13:24:19 -0700 (PDT)
Reply-To: mrsmadinadina@gmail.com
From:   MADINA DINA <dmadinadina@gmail.com>
Date:   Fri, 28 Jul 2023 21:24:19 +0100
Message-ID: <CAFNMNTjmH2RbHdkn7eruxgs3jCmtgZQK_3mtB2+SX8D6L+BCzw@mail.gmail.com>
Subject: HELLO
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: Yes, score=7.1 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_FREEM,UNDISC_MONEY autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:542 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [dmadinadina[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  2.6 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
        *  2.9 UNDISC_MONEY Undisclosed recipients + money/fraud signs
X-Spam-Level: *******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=20
Hello beloved,

I am Mrs Madina Dina, I am a sick woman who was diagnosed with cancer six
years ago. My main reason for contacting you is because I want to entrust a
charity project to you, I know this may sound so strange to you and also
extremely risky for me to offer such a proposal to a total stranger via
email but this is my last resort to get this done. I am looking for a
confidant, someone to help fulfill my last wish. Hope to read from you. I
will appreciate your selfless act towards the less privileged, I don=E2=80=
=99t mind
if you could be of trustful help. I will be waiting to read from you
urgently as time is of essence due the limited time I have and my ill
health condition.
