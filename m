Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 236EF766705
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 10:26:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233848AbjG1IZo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 04:25:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234958AbjG1IYv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 04:24:51 -0400
Received: from mail-vs1-xe2b.google.com (mail-vs1-xe2b.google.com [IPv6:2607:f8b0:4864:20::e2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C7F849FC
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 01:23:41 -0700 (PDT)
Received: by mail-vs1-xe2b.google.com with SMTP id ada2fe7eead31-4476a9e8812so400323137.2
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 01:23:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690532620; x=1691137420;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VITdmtGLQLGT4fU+DRADhN9JhICIDjdOtOp+++31gds=;
        b=LORxXc68KB4tEibFVmg9W0YfTHb+2Gs6GJt+KP0RhvLKYdR/8SbMJJodiQQhK+L07E
         gDCM2D1wnc0+62dFrcwykubsx7ycbvfRwB6xE3zYyuBeVln5OxQMAKPM5zG2reAmHiIm
         NTnSfEI2LqGnzI1doMeNsavDKh+RkE7eobt5MJlWlVW9j2P+lRbpUUVShT+q2NHsKaSD
         ABZyv8PZYGHdCk/Apj2Eslnh+D3QDwJgj2m+TcU0G7wSujmqcO+vGkgE+Vc+K3GnPE77
         2AwQ6bjlkHxKq4LloKH5wvF3+q/qtc8ftc7XG5ASuNJiZSzOXSpLsXNJHAAK88DhA21L
         C+0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690532620; x=1691137420;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VITdmtGLQLGT4fU+DRADhN9JhICIDjdOtOp+++31gds=;
        b=BGHOfDUFIconMnx+M6MyBmWzFkjAVSXX04yB1WeZNw8uT9ZwheP9eqAMeV74aVm7KO
         zODMitk6n6cz85q2/q256eixFquct7FV4tkivaEhcaKEYe3MnbUvPsVIGms/8+kFyQlN
         WUKnCRz6SUcGSjMB7YmuvjAC1OlXJfiZH5febXeQLWcOaiyYKa6aDpd6SEMt9APYrmWU
         tMcyp9kd99v0R9M5SQgmzqy/txfHqZo3Yu4KBmj48LCsJ2UcuVnHmPcarIIOnVqyCxF0
         oTs14Yhz5TgaaT2/Us/C6tJzMCLX1kUV/V0PJQoS+6RexKQAwztQ7s9j8QdkLHUcy3Xm
         OPsw==
X-Gm-Message-State: ABy/qLZXynihwvvOMDrJDaiwPaRghBCHUaSWi1oaAj+kuwSxnBWD2fJq
        fGv1SmFspRix4dqMws7kXAFGQ98g2nXkYu/rJgo=
X-Google-Smtp-Source: APBJJlHsa0ncbrhZyTOkqk9jroMNZLagoKo/f/WRmKrxBdiuIN67/R9SCcaBfaMpYpTRTBz7gcgnGpHRcjF/w8T2uJk=
X-Received: by 2002:a67:fbd0:0:b0:447:4e20:d2da with SMTP id
 o16-20020a67fbd0000000b004474e20d2damr1363499vsr.7.1690532620069; Fri, 28 Jul
 2023 01:23:40 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a59:d6b0:0:b0:3f1:5382:4ef1 with HTTP; Fri, 28 Jul 2023
 01:23:39 -0700 (PDT)
Reply-To: laurabeckwith001@gmail.com
From:   laura beckwith <jonnyangus51@gmail.com>
Date:   Fri, 28 Jul 2023 12:23:39 +0400
Message-ID: <CAEQMgS0kUgPtUae97hm13DKUtny+=iUkg+zjX1c9V3r9GkXCzw@mail.gmail.com>
Subject: hi
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=7.6 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_FREEM,UNDISC_MONEY autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5001]
        * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:e2b listed in]
        [list.dnswl.org]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [jonnyangus51[at]gmail.com]
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [laurabeckwith001[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [jonnyangus51[at]gmail.com]
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
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

-- 
Hi,
I am Mrs. Laura Beckwith, I have decided to donate what I have to you,
motherless babies, Less privileged and widows, because I am dying and
diagnosed with cancer about 2 years ago. I have been touched by God
Almighty to donate all I have to you for the good work of God almighty. I
have asked almighty God to forgive me and I believe he has because he is a
merciful God. May the good God bless you abundantly, and please use the
funds judiciously for charitable projects, motherless babies, Less
privileged and widows. I came to this decision to reach out to you because
I have limited time on this earth. I don't know you but I have been
directed to do this by God almighty. If you are interested in carrying out
this task, get back to me.
Reply at: laurabeckwith001@gmail.com
Yours Faithfully,
Mrs. Laura Beckwith
