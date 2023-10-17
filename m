Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71CC07CBA2B
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 07:34:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234457AbjJQFeG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 01:34:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234426AbjJQFeC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 01:34:02 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28E55B0
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 22:34:01 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id ffacd0b85a97d-32003aae100so4006485f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 22:34:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697520839; x=1698125639; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ptqK46Sao6TMrWb+csBUSCN7pOvytfhJ0CcS/J1cAwo=;
        b=BPyOWB3/88ozxanotVMqPDYLB0CeweVv1eYsTb/1ieuwhXGt+uc/LiTnhgr4SqxTLL
         9K6YFQQ1oZWgBb13tmXJLAAnYJKCyE/mkwprZ2yRNVM3xKohMt/Gz0qDl70480ANxZDc
         jNbZKIUZLCdlrHIFO12M4TsWng6VNYG+WnHHsyt5vCD1xqDjWYjycWjvkIPJU8awtnpa
         i6cHOvCjEacFRaD3/tLpG29y65c8KRtT4TaG1CdP2PsByqSrxXeGiXds7fbLMX4MiAuA
         H3M4F7UWIl2ziSRApJowhrBIq/D6dqGLgSvAmOd2gXC+d9lvHolNKcWbQjAaNg2R3xZS
         0SjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697520839; x=1698125639;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ptqK46Sao6TMrWb+csBUSCN7pOvytfhJ0CcS/J1cAwo=;
        b=DXXzpfY/00+okHB74ZXfGxK1mT/rrpWDK/0OwYRHyvF6JZfRu5aBmCwjZ875kYJNOa
         nPseCHmefAvpJvViI1EGwaJKNsQF/D4pu5qSxQPmmXx2BLr+OCbBU7gR8aPGoHsWFIk9
         pGBvDKk652LQ6Aram81WgHWZUUsoupDKcCOiP1hoXVFiHHxzVkay7IjQUP2oJcUVgsCc
         WWgZKHE7Ahu/Qgv+xBxmyeiJZlGN8JRgyAauUUorMbljfDUAeWNe58UIavYEMuZgYVUZ
         82jbtIvq2MvugctWuSf1iEOtFQ9/AJ/tM+GdGH58YReFGjS23/n+sf2Ahy9GvxUmSs60
         gKpA==
X-Gm-Message-State: AOJu0YyeyzbG8V836IGLQzQAcKQDIsn4Hs2Vpx3GHjTOdkqXKrQjbVoo
        Ln6w/9FBSDPYf1z7YtAFYawR3mZIQ+1ZVElThbo=
X-Google-Smtp-Source: AGHT+IHWk1Okg59zeduw6LXigVPyQV2I2HOAkxsPtBQSajfWM5Azb9UXiu9wa5OVRkUMVk6L5QJuK/CUim05nKOQQ2A=
X-Received: by 2002:a5d:5686:0:b0:32d:c850:b4ba with SMTP id
 f6-20020a5d5686000000b0032dc850b4bamr156269wrv.31.1697520839358; Mon, 16 Oct
 2023 22:33:59 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a5d:414f:0:b0:32d:9e69:e7b9 with HTTP; Mon, 16 Oct 2023
 22:33:58 -0700 (PDT)
Reply-To: Naomi_noguchi100@hotmail.com
From:   Naomi Noguchi <marcusslayer45@gmail.com>
Date:   Mon, 16 Oct 2023 22:33:58 -0700
Message-ID: <CAP9Jr=ccTvDP_LO6Tof++OMF9OsgmXkaTj=GbsNwr4YoGvFGXg@mail.gmail.com>
Subject: PROFITABLES ANGEBOT
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: Yes, score=5.3 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,SUBJ_ALL_CAPS,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: *  0.0 RCVD_IN_DNSWL_BLOCKED RBL: ADMINISTRATOR NOTICE: The query to
        *      DNSWL was blocked.  See
        *      http://wiki.apache.org/spamassassin/DnsBlocklists#dnsbl-block
        *      for more information.
        *      [2a00:1450:4864:20:0:0:0:42d listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5064]
        *  0.5 SUBJ_ALL_CAPS Subject is all capitals
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [marcusslayer45[at]gmail.com]
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [marcusslayer45[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [naomi_noguchi100[at]hotmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  2.7 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 Hallo,

Ich habe eine sehr reale und lukrative Gelegenheit f=C3=BCr Sie, antworten
Sie f=C3=BCr weitere Details.

Beste gr=C3=BC=C3=9Fe,
Naomi Noguchi
