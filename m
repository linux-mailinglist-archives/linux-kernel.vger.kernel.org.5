Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D3277A0184
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 12:20:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238142AbjINKUQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 06:20:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238107AbjINKUN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 06:20:13 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A37F1BE8
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 03:20:09 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id 38308e7fff4ca-2bce552508fso11136841fa.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 03:20:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694686807; x=1695291607; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vUsPFDXW/Q9zFshxxSMIyvX6rh0Ii52Ffm5CvJvVQ8U=;
        b=AbLRSGqvxl/0VjoABtB7IzUNxJF6SmN5VFfQw1pEQzHXeQqIyi0UXFKRI9WEvQx0IN
         mvidwzvhcz6enXZmX2qAKRpVDdy8V5wiETuI7LqzL3eTcE2fJOmvFyq998Mr3BQaX4cw
         FcdFL3arYKi7g7Co6kar72PozTVJ/Ogkq2iRI+OtbLDxVJDY7qugq3DuaM/qX5l8Pt1z
         lVG1lQPDZl4hQLN4BuWCt3m7rSd2EKn6QpidemKNxfEmQpRiKqOvIO1iZfIc6hYlECeg
         hQMr7Kzgv+VBwg8hME/aSNCoSp0qpIRWlz+zE1+brfltittuESzac0bVJrlmKvxujwaf
         TeGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694686807; x=1695291607;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vUsPFDXW/Q9zFshxxSMIyvX6rh0Ii52Ffm5CvJvVQ8U=;
        b=v2XbTr7aJJtZeHVYMfVkf8pEzKxty6fI9qhSu/SVYaEi939LfRzIO/1pUxEtFYzx6k
         0w+bbAjVoQWNOlVxitiK+Bn2JrHI2dIRzeNurn8QSwThPHtaloPEcWsGw4K7gvXgLxiY
         pVTEvee11m4oxjGkFHC7aGVSTaIZ7AkrJ6/XPpcuF1hdI1pPSNCL651ALwHwaaeQu4WP
         BcmjEdoxCwc0PX1McS9h9ELqQ082JiIcbaNIMzKvrJpE0Jf5YbV5n7dIEqWCZ+KcBh5c
         qlqklYjTKG0C22eObviEIrshn1rek6GTEVTy4+l3NI3PIoZ+fglCmresVSm6U/9rtluP
         uOlw==
X-Gm-Message-State: AOJu0YymLbGomY65Rt29ZO7Y4hnklyi/0+tMzGvH4u5+o24v72L9yTsC
        TsgQ6CBhlaDyUgLHKljyEgBy1k/sKpQOhCq21NU=
X-Google-Smtp-Source: AGHT+IFIsN88voMYnrvA/UIjtNuP0nzZ9rGS2RNWI9JyduW1fko8tORK+i57gvVEZ3U20BNdIOSV4Y24l6XXmaJt4wg=
X-Received: by 2002:a05:651c:1212:b0:2b6:e2c1:6cda with SMTP id
 i18-20020a05651c121200b002b6e2c16cdamr4398394lja.46.1694686807352; Thu, 14
 Sep 2023 03:20:07 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:aa6:cad5:0:b0:26f:c704:12d9 with HTTP; Thu, 14 Sep 2023
 03:20:06 -0700 (PDT)
Reply-To: americabnkcapitalloan@outlook.com
From:   America Bank Capital Loan <gerrypricebigbustours@gmail.com>
Date:   Thu, 14 Sep 2023 11:20:06 +0100
Message-ID: <CALN4VLF2pRHA1AiQxTRb0ZykJ=ohzNSA8GRv0Mteszxrvuxo+g@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-- 
Do you need a loan? How much money do you need?? We offer long and
short term loan between 1 - 20 years time, from the ranges of
USD$2,500.00 - USD$1,000,000,000.00 at 2% interest rate.

Apply now!.

Amadeo Giannini,
America Bank Capital Loan, (Abcl).
Head Office: Corporate Center,
Gauley Bridge, WV 25085, USA.
