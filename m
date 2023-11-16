Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BE857EE18E
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 14:31:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345163AbjKPNbj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 08:31:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230348AbjKPNbh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 08:31:37 -0500
Received: from mail-yw1-x1144.google.com (mail-yw1-x1144.google.com [IPv6:2607:f8b0:4864:20::1144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FE3384;
        Thu, 16 Nov 2023 05:31:31 -0800 (PST)
Received: by mail-yw1-x1144.google.com with SMTP id 00721157ae682-5b3b17d36d5so16333987b3.0;
        Thu, 16 Nov 2023 05:31:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700141490; x=1700746290; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CfiuMGKhBfphWIUturZaCUkLZwNpGAf3qvHrSRN2raQ=;
        b=HLszVHLzmQEbn/vhxv6vxBDhGBSocl4cvf6vFLXsKjInozK/WErQw7IlZnsn4pVQ1p
         Mxt9rAL/Nr2EK4qAbTSdWlUfGEB9tu4Wc783LZGWCjq3hGlgHcHKDyEhc/YOoPBDrrbI
         2gy9GygRYnyVxwHSL+8PIlJci+MZQLsN2Ap5RHDyfWJ9VtJhATBVOXgnK5UDgXHUVsNs
         PVneV+qJZLZ6Xivc2AUL8wF+xFv3fxxr4BIr9XnIaSdAxeK9s1Xqvr2wMrR6U6AIgJAi
         8og+YbkFpoT36+eFnczN+eqO/J5XtG3CyNtotbz96Zykm2j+wkKVKZwrQUg/2K38m7yW
         Srgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700141490; x=1700746290;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CfiuMGKhBfphWIUturZaCUkLZwNpGAf3qvHrSRN2raQ=;
        b=bjUbUErqdejKNisfkCCodU1S015MppHcbq4f/BwqTe4/QA+oYSpo0U14vx0QZGnyAT
         gJfYosD+lPg4UO7EKTDvZ2VRbatQMcGOWyKNgIDOm4lFcfhMBHxCXvSifiXMi+U70opj
         zC7OHAAruAP1B3D3PbJmNqeyPKUMw96f5FE2LiGY9iyxBjMb1lDDS0dLeUnxx/niS9WK
         dlC0+X6wk9BHs7llnTACTzQVfuIuTXrn+fIK+LYsj2I3XXLILuSwIbeRnRNR2ZhoSM/y
         zfD9Vhjengfmvkv6e9o2v1UJ7ypTfopG0btynouClJVlaxz0wQRaVLtX4ZqdSbc3+FrZ
         QhIw==
X-Gm-Message-State: AOJu0YxgceXFt6Yta7wHqiEGLuDE13YkQsOTQVzaRvNGXO1g+nCh+hwV
        glqJnqza7A3QgvVi3gel8thPt03bp7Ls7bYTdok=
X-Google-Smtp-Source: AGHT+IENFOmg1lrjmrVQhozbiwA6K5ALsuBEu2RtIkJ9gRcHAoKLmt2cXls+8xeDfYonSVUglur2ZwnnwwK9qkmkFCg=
X-Received: by 2002:a0d:ea51:0:b0:5a7:dad3:cd21 with SMTP id
 t78-20020a0dea51000000b005a7dad3cd21mr940109ywe.10.1700141490180; Thu, 16 Nov
 2023 05:31:30 -0800 (PST)
MIME-Version: 1.0
References: <20231116125433.13285-1-579lpy@gmail.com> <20231116125805.13466-1-579lpy@gmail.com>
In-Reply-To: <20231116125805.13466-1-579lpy@gmail.com>
From:   peiyu li <579lpy@gmail.com>
Date:   Thu, 16 Nov 2023 21:30:54 +0800
Message-ID: <CAELPsEYKgmcPh=9FQ44d_5AwHYd15EzASEKV31Gcv_5rdrPJDg@mail.gmail.com>
Subject: Sorry,please ingore this email,this one is no is no different from
 the previous one.
To:     jic23@kernel.org, lars@metafoo.de, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        FROM_STARTS_WITH_NUMS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I'm sorry that I used the wrong patch name when sending the email.
thanks,
Li peiyu.

>
> Add support for HDC302x integrated capacitive based relative
> humidity (RH) and temperature sensor.
> This driver supports reading values, reading the maximum and
> minimum of values and controlling the integrated heater of
> the sensor.
>
> Signed-off-by: Li peiyu <579lpy@gmail.com>
