Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA057788F7E
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 22:02:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230135AbjHYUBk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 16:01:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230283AbjHYUBc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 16:01:32 -0400
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A543E2686
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 13:01:30 -0700 (PDT)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-58cd9d9dbf5so18938727b3.0
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 13:01:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=firstdatasolution.com; s=google; t=1692993690; x=1693598490;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2mJBOpmBBjW3YYepuO3umIyutC/2LEvzV7CTxk25B6M=;
        b=ux2R+mVpeBKY1oY2LLesB9ljwBSZ4jOeCdi3Gs53ospy1TrUCHSBPTgnfrFWa/+aiz
         os2EIbJRNGVkybix0I9gsRBkMrs2zGig3ah8qEafpbJlaW12ADA/TyBZXvkC/ImKfw1l
         y0wQIxICGF/d4JepVt7cpmavGk1Ya5fMbZHMfCJ92s5j0mU70pvB987BWMYyOO8U8R8y
         3mp7d8R3RS9yJEdEazEaWwdJfzni/3rUQiWHTUcn+ngHsZPWtLg4iDbvwpCxNrs52aXp
         3pAM/UAeg2w2T67nlEZjVxyrpy7KrUJk6C11T21HQ+hGOhuRMO/n711rHrbBgvk+FPHS
         yXlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692993690; x=1693598490;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2mJBOpmBBjW3YYepuO3umIyutC/2LEvzV7CTxk25B6M=;
        b=BCb5p9j3rfkvg5bIe6p2V4BoNo6207inlcRn9kI7tHdbBiunAmy+T04GChVrnrwZkR
         m9Rjs3/CwBINtyPdoIflSg/WBV9SBsnGiBfr2A0IdxYpLxBiH7Ae5Hs3TNYnuG7/RZhA
         qeeBZOA2mj9LVyJw+zLXoZvIbEHO66mRbFwJMujg2BjA4AVMyAQ0U32KQ7H+Bt0mzTpU
         pskB/acyQSv+uEmAfETM9T/AYFIZxaeyIYD/5I8IOMKARAD4WGwtf/7/nLWGUV2yXMxt
         IqflmN/xQOLPoy+okkIs0SqFmTgr3OVqEptC07IA5k/oWMOsLD01Vqxf7hrOd5Aehaab
         Pb1Q==
X-Gm-Message-State: AOJu0Yy+gDd2Vmn2bU7c5vF3aLJI9zG/OY7F2UB7KKTHoTrCsRVomiFj
        2obXJQndt6UVR9aU5Hc+mwL2EP+oxZiZHATJwNkT8Q==
X-Google-Smtp-Source: AGHT+IGMaBD0mWBJr1qPx/m1FOr2bNwxmeeamXN1dZgfla7FjRQh3KgfHv3Vno5aGG8CRjIxjasDDtkbBZdiGTsbsKw=
X-Received: by 2002:a0d:db4e:0:b0:576:87b1:ae0d with SMTP id
 d75-20020a0ddb4e000000b0057687b1ae0dmr18904867ywe.21.1692993689765; Fri, 25
 Aug 2023 13:01:29 -0700 (PDT)
MIME-Version: 1.0
From:   Sarah Jones <sarah@firstdatasolution.com>
Date:   Fri, 25 Aug 2023 15:01:14 -0500
Message-ID: <CAGrML=EYBH=Hz+f81SUhdnm0jjW0Jdu7dbATjdQ9+RNE_bgcNw@mail.gmail.com>
Subject: RE: IT Security Professionals Database- 2023
To:     Sarah Jones <sarah@firstdatasolution.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=2.6 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FILL_THIS_FORM,
        FILL_THIS_FORM_LONG,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Would you be interested in acquiring IT Security Professionals
Data List 2023?

List Includes: Company Name, First Name, Last Name, Full Name, Contact
Job Title, Verified Email Address, Website URL, Mailing address, Phone
number, Industry and many more=E2=80=A6

Number of Contacts: - 130,768 Verified Contacts.
Cost: - $6,989

If you=E2=80=99re interested please let me know I will assist you with furt=
her details.

Kind Regards,
Sarah
Marketing Coordinator

To unsubscribe kindly reply with "Leave Out" in the subject line.
