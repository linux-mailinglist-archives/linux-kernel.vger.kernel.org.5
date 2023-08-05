Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDEED770FAC
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Aug 2023 14:41:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229899AbjHEMli (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Aug 2023 08:41:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229719AbjHEMlg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Aug 2023 08:41:36 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80668E68
        for <linux-kernel@vger.kernel.org>; Sat,  5 Aug 2023 05:41:35 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-4fe61ae020bso1015764e87.2
        for <linux-kernel@vger.kernel.org>; Sat, 05 Aug 2023 05:41:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691239294; x=1691844094;
        h=to:subject:message-id:date:from:sender:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NZZT53rI27g9Y8engSXkXFM1Ahela7CZCFOxqAFCkkQ=;
        b=XhlQ5voz2le5CJYh3Ae7qM594dyKgKm4UdT3ddQHp4XhdLUf8Lzc6v/4U9JbItZDxP
         W4kMIzhMVttfcXCRP1yyNts6zeXL/15pQ7QFJkA/Y4tBaYNBGOEM+XAflFLV5sEHh+8d
         JgDFGVQtE2+BSW7GZf/d4uGHQgdcnhFP5WcN4AkDvfdd3Lg3W7F3mqro3G6vKZZZkjha
         aWptj51zp4T/gqX3YuDEwWBiN1Bs6X4xZYYsIRdbvaBKoED1gpzZ3j0kdr2700UlXyAB
         oxvft8zIt2Ht3xp+R0fPYe0puKr3qZtDLvvNCwdsNQaa1EPT3SLG0CAZNl8+2oXNhML0
         wfZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691239294; x=1691844094;
        h=to:subject:message-id:date:from:sender:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NZZT53rI27g9Y8engSXkXFM1Ahela7CZCFOxqAFCkkQ=;
        b=IxDeKh/hkTBKVosV4srgpS1UCDgLOv/X4w9x+tcvEb1FGZzY7MEOm89MByALiYfXH7
         DDo/vInJvV2uP+8kyHlfTY+2H/7RHbrCIvktpebTmRPaBOOvn1lQIov0qVvssBGwzctm
         0UH6Je4EjNiKRPd0P/madirCKuUpon7dD32JF3yGgWcgeaeq/cu0JtTP9Yr53Or5MZiN
         xadWpn+u47mliR+M9mlpuDYxH7mer9BwcFFmqchpwMRpLDUGu/OtOo9PiQ5VQlANA1vj
         u5I1EvWuz2uORT98LfiYpnXsCLpoOXRyNBOH1He5/M88ONbNSZ5Z4DzKXY81ulp6KUVr
         2MOw==
X-Gm-Message-State: AOJu0YwSRNUX/FlPzG2Rjg47CrDMFhX1NXpAmnzYwt+4yXaW5avftZXy
        GreTqAdUDxb0dtBryqhQMQDZNWjcSl5ymd/j7ro=
X-Google-Smtp-Source: AGHT+IHxQDc7rpO+XW1tJNyrSDU5AloIR/OFuVLOMNO/i17EsBTladsVfvUuuFUMoPDZ+K1e44aO74aTpmqvRZXUqc4=
X-Received: by 2002:ac2:5f8e:0:b0:4fb:8c52:611 with SMTP id
 r14-20020ac25f8e000000b004fb8c520611mr3014136lfe.38.1691239293596; Sat, 05
 Aug 2023 05:41:33 -0700 (PDT)
MIME-Version: 1.0
Sender: drrachel2019@gmail.com
Received: by 2002:a05:7412:b14:b0:d5:fa57:4ab with HTTP; Sat, 5 Aug 2023
 05:41:33 -0700 (PDT)
From:   "Dr. Ileana Velcea" <drvelceadesk@gmail.com>
Date:   Sat, 5 Aug 2023 00:41:33 -1200
X-Google-Sender-Auth: KrJcV5iqpcl1I3zUNEcBoHknYME
Message-ID: <CAOrB_YYALL7avnF5Fxpudg=2Ge1Nx83pvGoJNn_rzzb3GQW=8w@mail.gmail.com>
Subject: UPCOMING CONFERENCE MEETING,..
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=1.4 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        SUBJ_ALL_CAPS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Colleague..
On behalf of the organizing committee it's my great pleasure to invite
you to the International Conference on Drug Abuse, Rehabilitation,
Human Health and Diseases which will be held on 20th to 24th
November 2023 in Houston, Texas, United States.

The organizing committee and sponsors are responsible for
participants' visa processing for those who require a visa to the
United States. Free round-trip air tickets for participants will be
provided by the organization, the hotel accommodation booking cost
will be your own responsibility.,

We sincerely welcome you to contact us back for more information,/
We look forward to seeing you soon!
Warm Regards,
DR.ILEANA VELCEA
EEW90
