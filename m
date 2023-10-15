Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 881407C9944
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Oct 2023 16:02:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229999AbjJOOCR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Oct 2023 10:02:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbjJOOCP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Oct 2023 10:02:15 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A906B7
        for <linux-kernel@vger.kernel.org>; Sun, 15 Oct 2023 07:02:13 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-53dd752685fso6301042a12.3
        for <linux-kernel@vger.kernel.org>; Sun, 15 Oct 2023 07:02:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=healthlifeteacher.com; s=google; t=1697378531; x=1697983331; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=QO/fRdyHALvAHFDUDJdI04o2g1JjPq8gz/VhmL4zMzM=;
        b=UrfyzQ7BQllsC7mhSd2RefKxLXZWknht+BIF5rM9yTYS845uX9Q9dGwF4Em5IabGZa
         6keRDNsf8/G4NGcqfDuSTCVw1h90UEvnz9l3RncU49VGIomGaJ92S9j+bnKB+VwF66Dd
         KuZBBv1dMa7/MdwWUYVL/as7tmZY1RstYMtPpatscMPzBZypHcQNcNgFcuFWGtQwPGtn
         N97bka86WT99LXIW0B9ZPk6OF++ltMrItWB2jKfdycAW7EYMdY3b583U2AMp7wUVr73C
         cXXhnk442Ox5laXYgvpZRIssjWwcA8t5cRUp1Ywz38eB8YYOQg9757CF67cfvZzOxDf/
         Q+Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697378531; x=1697983331;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QO/fRdyHALvAHFDUDJdI04o2g1JjPq8gz/VhmL4zMzM=;
        b=cxv7QjDTSDFkIK9DMk20cEM4hNM19C0+955l2APdlItdJZ/kL9DEbP5OSNQ3KOtWU1
         VW/uQUL6IyY0Adm4/ZpazRjhx3gAnL1M/ctvKjPq5RCHG0m6GfPnDy6r1C97OcBboIp8
         LvqQs2297lqrbip+RggRhX2y/7EKhR3S+SfG5bE8XI3GghR9YRho/+zu9sk+XCKnk4BE
         FpJa89JWi40cO0StVXo2j7Rthzj3dQUk8b3uXGWo+cXlpocY2mbT2EFHDFp4jGtQXxZo
         iJbUhJIdNgvu/1cnj7ncaweZhzwWxIU9hMXGHtsOvDjWk/0jGbhFBkuzs3gRvBcuxyGU
         et8Q==
X-Gm-Message-State: AOJu0YxwW+/uos6Eath1ciX9UCPPzPAgurqAmqDtjjw8oUYfHVLX6qGp
        az3jLC1kT3Hu3nEkvEGaF+1AuDh+XGKyOG64Ghgy6I4WvYRKSlbV
X-Google-Smtp-Source: AGHT+IH0K0b7vtHD44tnbbuP8RspMVu/tF8i9KmjKS80jdlAzKoSlOiXDzYzuCf2Kgoo3xYjaTcJGos+ncB0OapOdpY=
X-Received: by 2002:a50:d689:0:b0:53e:6da7:72b7 with SMTP id
 r9-20020a50d689000000b0053e6da772b7mr3134283edi.20.1697378531382; Sun, 15 Oct
 2023 07:02:11 -0700 (PDT)
Received: from 97756595488 named unknown by gmailapi.google.com with HTTPREST;
 Sun, 15 Oct 2023 07:02:11 -0700
MIME-Version: 1.0
From:   Jennifer Sanders <jsanders@healthlifeteacher.com>
Date:   Sun, 15 Oct 2023 07:02:11 -0700
Message-ID: <CAPqfvEuK3ysLRwNMxR20Tu0WB__XxH9ALhrQPU78h+riQGFH+A@mail.gmail.com>
Subject: Something for your website
To:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=1.6 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URI_DOTEDU autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Back discomfort, incontinence, and breathing issues are just a few of
the many side effects of poor posture.** And regrettably, given how
many of us spend our days hunched over our desks, it may be very
simple to develop terrible posture over time.

I'd love to contribute an article to your website about how to begin
correcting your posture and its advantages. Would you be willing to
publish this piece on your website for the benefit of your site
visitors?

I appreciate your time.
Jennifer Sanders
My website: healthlifeteacher.com


**https://www.health.harvard.edu/staying-healthy/3-surprising-risks-of-poor=
-posture

P.S. Reply with =E2=80=9CSend a new topic,=E2=80=9D if the above suggestion=
 doesn=E2=80=99t
work for you but you=E2=80=99re up for receiving an article. And simply rep=
ly
if you don=E2=80=99t want to receive any further emails.
