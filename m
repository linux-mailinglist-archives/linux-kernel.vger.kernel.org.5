Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE8497B4C4D
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 09:11:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235698AbjJBHLW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 03:11:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235684AbjJBHLV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 03:11:21 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A0F5A4
        for <linux-kernel@vger.kernel.org>; Mon,  2 Oct 2023 00:11:17 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-5334f9a56f6so21389818a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 02 Oct 2023 00:11:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696230676; x=1696835476; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/rL+TycpMQLfB5P4Zn9xgGfUWg8yPCNTwrE46ZNldMM=;
        b=fotVtHlN6CzNAbxz5vo/PqopF8PLE/FFMGOErEKeF2JacsXY2F9uJr3743CsellrBX
         VzwfPNZNok3INQluFGzFnvbdFUwNJyxQeX0AtBH0nkFN2xaw8nIZgm772JamcBPEv5Br
         PqU9lvNvDT383biHVUucGD6NNpeWPH78RSKmp2W+VtUF94gp+Yc7wHYO2UJFxWAKorHy
         NBPRH+sudKDdV4OgKorWps5Jrn4T0p0b0AR0XWlJDICPmcsPL6cOpf+/UWjeOq/WsUBX
         Bx7I/RNXG1Oy8E3rw2ehR0cD3NRKs/ykBAiuXv+RZOKHnf90QWryC87UovqlDjFugPiK
         +pVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696230676; x=1696835476;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/rL+TycpMQLfB5P4Zn9xgGfUWg8yPCNTwrE46ZNldMM=;
        b=m20ClZvnUpIIWwb+zGQocVee3MilBD68z1PYV9xGmnG3dzmoLqYjiNXl5mv8gftk0w
         Zip97rbzVcDlWTVtsV78hF1MlwAgY9TL/nqWA+eX4cL/PqiJpVKR0Fga1j8U04AiuD7q
         jAQ3DxWPz3EO9dbqGV0u6hZ1VdM1D2s9/T1Sg+xMnRym6xq7HXDUNOOeM3YwXfD0H/oN
         bwCQYh7y6DBz/UteBCBu3JMX+YwHKm8tatWDNnlu6idGI5IakNAIIcUGbvq1NXxPxxgW
         Yzms2K8oQVucRJkUmHJUwL3KROt941eUSVBUnEQ7hQLkRDZGnu1pW/zHhyoIt3mBZHoX
         drMw==
X-Gm-Message-State: AOJu0YyiI53RQo8rCuS8LKu95auKiRYMDWGYdUKNtZkFyk/rrbMypOLt
        N+DuHK/T/EqxiGKJys0RCVDbUOpdUxIoHqn961M=
X-Google-Smtp-Source: AGHT+IHLZlXbbvc1YqHZv77usNOMtnil8ooeXfPrqVBkDum3beiEXjgjgN2TUxGOWsiKkTPoo4gdh+6c0NyFFUavrJk=
X-Received: by 2002:a05:6402:1257:b0:534:8392:879d with SMTP id
 l23-20020a056402125700b005348392879dmr9350085edw.37.1696230675192; Mon, 02
 Oct 2023 00:11:15 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a54:2a92:0:b0:22d:7aeb:6361 with HTTP; Mon, 2 Oct 2023
 00:11:14 -0700 (PDT)
Reply-To: dravasmith27@gmail.com
From:   Dr Ava Smith <gdr0026@gmail.com>
Date:   Mon, 2 Oct 2023 00:11:14 -0700
Message-ID: <CABpE2Pu1DfXyLk8azsGuOg0XFHB3GQwqa4X0L=X5cs023-QrVQ@mail.gmail.com>
Subject: GREETINGS FROM DR AVA SMITH
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.3 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,SUBJ_ALL_CAPS,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: *  0.0 RCVD_IN_DNSWL_BLOCKED RBL: ADMINISTRATOR NOTICE: The query to
        *      DNSWL was blocked.  See
        *      http://wiki.apache.org/spamassassin/DnsBlocklists#dnsbl-block
        *      for more information.
        *      [2a00:1450:4864:20:0:0:0:52c listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [gdr0026[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [gdr0026[at]gmail.com]
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [dravasmith27[at]gmail.com]
        *  0.5 SUBJ_ALL_CAPS Subject is all capitals
        * -0.0 SPF_PASS SPF: sender matches SPF record
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  2.7 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-- 
Hello Dear,
how are you today?hope you are fine
My name is Dr Ava Smith ,Am an English and French nationalities.
I will give you pictures and more details about me as soon as i hear from you
Thanks
Ava
