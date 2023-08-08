Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D26AD77470E
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 21:08:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234659AbjHHTIy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 15:08:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232556AbjHHTI1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 15:08:27 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6943E32081
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 09:30:47 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id d75a77b69052e-40c69dde7aaso8909901cf.0
        for <linux-kernel@vger.kernel.org>; Tue, 08 Aug 2023 09:30:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691512217; x=1692117017;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ykbYwA3HeGsCN8WmJjHX8Ai4t3OUIoDB8yD1nUGpb8M=;
        b=HLdyvpnpVWamu0hZ0jHqWhUDnjfEbt3V8vb+Od1BvQDXnDAwhug+mJziC7/X9GafTH
         1Jljhe9jB/BcxSMLPBa/29ow/hJa7jJYZRrx7+UzKbH1X3m8RD/APXImJUZwp+uqvDfw
         h9wU1mkCFz5W0qV9fU4DXMR2aOnJGfZx1qe4V7ePxE/abrECgqlo9c8ZmURqpQsDfgFV
         Fpw98BIVAD7xRC4QbenePLmPXOnZ2h3MTAqaBSyFbkFfEQR6Iv7Z5J+margsuIsYi4sn
         XGV7SBJaXUy/yPMyIvOgzh4br2aSuBHDKo+OgEGfQz7j5oBp3QILJMftf809Nwg/yEts
         oJKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691512217; x=1692117017;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ykbYwA3HeGsCN8WmJjHX8Ai4t3OUIoDB8yD1nUGpb8M=;
        b=HFMbnkwmRs8+adVReSLrJUgS5M+783QF1TX2uJCs4e4LUHgTNrbg84HRfXySLPP7I4
         +DERJVXXQyyuYOVd9Mfbmzd6UkydDKWEdqvZaZZ0oX8CJ0dOdE1GMmYH6LejfsNjytRt
         AzBqNEXgz+tQ4ULujB4wNlXi2nUxDIdc3Y9zFoTcQ0Dzw6xxHHxLfzgImivCmVylYOxc
         GiYRckJtwJkFJnh/kKwEjKnHj/3//kuja77DjUdtaVl25PukwZcsOzh9we0i94hZuQQ6
         PtafrHDwPN+dGNEGaTB6k6gpYHZsGzJsj6zS3HGcXMrtX4MygJYMk074v5F5MzILzm9P
         N5gw==
X-Gm-Message-State: AOJu0Yz2eTC1JADGWiN6opE+1JSctyIcTL3tewrSIrMSCLvB+Vi+qPVO
        xQ6vtHFh+Dzyz3kyKL5sYwTy+PTfxKjaNf6PV6c=
X-Google-Smtp-Source: AGHT+IE1CmZA7iWbjgXPPg4GEUfYICSEut3w4dAJeKtsZEVK3KTmlQJaW6xK0WN/gWKCvVO7tisFNRG8Wax6X83pku8=
X-Received: by 2002:a05:622a:199f:b0:40f:da40:88a with SMTP id
 u31-20020a05622a199f00b0040fda40088amr282882qtc.4.1691512217424; Tue, 08 Aug
 2023 09:30:17 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6200:3502:b0:50c:5f4d:412e with HTTP; Tue, 8 Aug 2023
 09:30:16 -0700 (PDT)
Reply-To: otatianaa557@gmail.com
From:   Tatiana Oligarch <ewakara23@gmail.com>
Date:   Tue, 8 Aug 2023 09:30:16 -0700
Message-ID: <CA+XtqDxLpe5tsYDMmaQ3dKyh14jQL1uqkM+sU-pNmWiS9HeAtw@mail.gmail.com>
Subject: Kindly reply me
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=7.5 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,UNDISC_FREEM,UNDISC_MONEY
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: *  0.0 RCVD_IN_DNSWL_BLOCKED RBL: ADMINISTRATOR NOTICE: The query to
        *      DNSWL was blocked.  See
        *      http://wiki.apache.org/spamassassin/DnsBlocklists#dnsbl-block
        *      for more information.
        *      [2607:f8b0:4864:20:0:0:0:831 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [ewakara23[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [ewakara23[at]gmail.com]
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [otatianaa557[at]gmail.com]
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        *  2.6 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
        *  2.8 UNDISC_MONEY Undisclosed recipients + money/fraud signs
X-Spam-Level: *******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

My Greetings,

I write you with sadness in my heart because of constant attack to our
country Ukraine by Russian army which has caused lots of deaths,
destructions of properties and homes.

I am Mrs.Tatiana Oligarch, a citizen of Ukraine currently in Kyiv, I
am looking for a reliable partner who can help to receive my fund
deposited in a foreign bank for safe keeping and investment in good
profiting business. I want you to help and receive my fund in your
country and I will come over to meet you for foreign investment
partnership under your care and advice.

Hoping to read from you today and know your sincere opinion in helping
me genuinely.

Sincerely,
Mrs,Tatiana Oligarch
