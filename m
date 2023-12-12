Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22D7A80F11E
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 16:33:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376887AbjLLPdn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 10:33:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376793AbjLLPdm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 10:33:42 -0500
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B2EF95
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 07:33:49 -0800 (PST)
Received: by mail-lj1-x243.google.com with SMTP id 38308e7fff4ca-2c9fdf53abcso56323571fa.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 07:33:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702395227; x=1703000027; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eaUgBVDv8XJC9KwT1nYw3VO0329gUyssPKGDQaCxM90=;
        b=iAekqNpf33lCUueSaUNZxByAx24Xwr2A+GzzW8elM93GkVRbFUMCGe1H7na/6TLvtB
         oIYYtlNer61nPrGZAhekyRqv2pLNmdqwQaz9p6hbTWTM9v1HF7FM3fwBukYH4i056dLt
         KWDRT60zfgbG/pbiCMmcytthCKLW/tOlV8x2SUvVs3ekoyKUXXh8CHafCnwXl5m40FS+
         PYkijUSnrXfPeLchtwcr5/QzZp7p2/G54EKfwwdtAp96QYZ9/ve8QZ2vgM2ke62OoEak
         llfav7J4NxoM1HouJyFK4+EabCBymlD51akPEgJ/BTYTKCA60EOgXemiZ73TCWfyzA3v
         +G8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702395227; x=1703000027;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eaUgBVDv8XJC9KwT1nYw3VO0329gUyssPKGDQaCxM90=;
        b=TJzfaqNogjaK8oq0twX1O23tItAJv35EShdZp1e1IIeULVIrUF6p/0OMmasbLDvXI+
         ssGLrQ9YI3LEGxBhukl8gZCuQbsnINwT0MOSJWx+Uy2SApCCyhUGTXccdnn9hP2U+pIt
         h+2uMkhhz8vtVUT6CJjlcRar2abS6ceYu9Kr3roBn56hxzpCScTcd3+vKGSu73ql5pGt
         lGl+Z/4F622Pixjey+Lh5teIxdZcuKU1lC0ocwRWS+tBp2kQmp2SO9qgdUPRKX+B1L0o
         igcBcUvRpPda98QUa+fu5c4qxmAvaahj9NLcOB65GyEX04GTILdX6Kqc+5+QD6OcZbxS
         70Aw==
X-Gm-Message-State: AOJu0YxlYVffXrD8BjulNBHAN1TA4GXsG4VwOLKzKlBUURe+aVyFRlBD
        f4m5lQhDD3VBK1PAHSMGurV+sypIcS2NdgXoYKQ=
X-Google-Smtp-Source: AGHT+IHqSjr2kv2STrkl5BDddq2zRKONNEgmKOqxuueoGQd4o+visyIdqeUUyHc9OGWxdLkpT59lYnpJo7Nil8D30b4=
X-Received: by 2002:a2e:888c:0:b0:2c9:f4af:fb9c with SMTP id
 k12-20020a2e888c000000b002c9f4affb9cmr3042224lji.22.1702395227004; Tue, 12
 Dec 2023 07:33:47 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:ab3:6f17:0:b0:24e:383c:d95c with HTTP; Tue, 12 Dec 2023
 07:33:46 -0800 (PST)
Reply-To: zongokatyh@gmail.com
From:   kathryn zongo <aishagaddafi519@gmail.com>
Date:   Tue, 12 Dec 2023 15:33:46 +0000
Message-ID: <CANJ_fLECdxtzpwKAc1k+1TDfDqSocrht1xp7K6xDSqd9Uv6_kQ@mail.gmail.com>
Subject: Compliment of the day!!
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=7.3 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNDISC_FREEM,UNDISC_MONEY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: *  0.0 RCVD_IN_DNSWL_BLOCKED RBL: ADMINISTRATOR NOTICE: The query to
        *      DNSWL was blocked.  See
        *      http://wiki.apache.org/spamassassin/DnsBlocklists#dnsbl-block
        *      for more information.
        *      [2a00:1450:4864:20:0:0:0:243 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5011]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [aishagaddafi519[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [aishagaddafi519[at]gmail.com]
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
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

Hello Dear,

Nice to meet you, i am miss katyh zongo, very sorry for the informal
manner in which this letter is reaching you as it was necessitated by
my urgent need to get your response. I came across your email from my
personal search and I decided to contact you and I've something very
important which I would like to discuss with you and I would
appreciate if you respond back to me through this my email address as
to tell you more about me with my photos, my private email is as
follows (zongokatyh@gmail.com)

Thanks
Miss katyh zongo
