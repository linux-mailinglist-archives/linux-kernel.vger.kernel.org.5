Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C96FC7A0A09
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 18:00:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241512AbjINQAt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 12:00:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241400AbjINQAl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 12:00:41 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F33AD1BFE;
        Thu, 14 Sep 2023 09:00:36 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3017CC433CD;
        Thu, 14 Sep 2023 16:00:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694707236;
        bh=fLr80EmpobomSucOxfoP3rCvSCDStgGboBA2MdKy7wU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=N8+JXepUFSMhGk7Rm3OSJjeqbhtKzfwivno7KYtODddPZ0FzG3rc7o+GpJx72PVEn
         8Qtaqx5CAoUUloKwZTforIGnbYjCJwDL0jbANkNd4rCFRJVoUxjLXxjNazgyaxb4Hr
         l3/z6mwRb29uLHB7Q7SYkcBP1iMawvrBttkHQbXvxnKOjdAk8aGpaa2y0Vy9tdQSMv
         3H6gKFRuROa9iezJNjzpKmn3PMDU0SvVTUvwLhwOkKwehszY70JkT+f+sJgdO8/pI/
         5egXRXLjoWrYpGjj7K0p3gyrpofxvGmJ9yvxT5XqxTVRrojvtzPe2sCPdV4nxy+yQI
         QHKHtXaYfFsBQ==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] soc: qcom: socinfo: Add SM8550-adjacent PMICs
Date:   Thu, 14 Sep 2023 09:04:24 -0700
Message-ID: <169470744875.681825.8495576634119743597.b4-ty@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230830-topic-pm8550abcxyz-v1-1-3c3ef3d92d51@linaro.org>
References: <20230830-topic-pm8550abcxyz-v1-1-3c3ef3d92d51@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 30 Aug 2023 04:42:43 +0200, Konrad Dybcio wrote:
> Many of the PMICs were missing, add some of them often coupled with
> SM8550.
> 
> 

Applied, thanks!

[1/1] soc: qcom: socinfo: Add SM8550-adjacent PMICs
      commit: 3b1eba1882b74c0e9b9f158ee027e309b1df4782

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
